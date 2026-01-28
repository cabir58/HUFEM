"""
HUFEM - Hava ve Uzay Fizyolojisi Eğitim Merkezi
QML-based Modern UI Application
"""

import sys
import os
from pathlib import Path

from PySide6.QtCore import QObject, Slot, Signal, Property, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonType

# ==================== DATABASE ====================

import sqlite3
import json
from datetime import datetime


class Database:
    """SQLite Database Manager"""
    
    def __init__(self, db_path: str = "hufem.db"):
        self.db_path = db_path
        self.conn = None
        self.connect()
        self.create_tables()
        self.insert_defaults()
    
    def connect(self):
        self.conn = sqlite3.connect(self.db_path)
        self.conn.row_factory = sqlite3.Row
    
    def close(self):
        if self.conn:
            self.conn.close()
    
    def create_tables(self):
        cursor = self.conn.cursor()
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS devices (
                id INTEGER PRIMARY KEY,
                name TEXT NOT NULL,
                code TEXT UNIQUE NOT NULL,
                color TEXT
            )
        """)
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS participants (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                tc_no TEXT,
                first_name TEXT NOT NULL,
                last_name TEXT NOT NULL,
                title TEXT,
                branch TEXT,
                institution TEXT,
                email TEXT,
                phone TEXT,
                notes TEXT,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP
            )
        """)
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS training_groups (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                description TEXT,
                start_date TEXT,
                end_date TEXT,
                status TEXT DEFAULT 'active',
                created_at TEXT DEFAULT CURRENT_TIMESTAMP
            )
        """)
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS sessions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                group_id INTEGER,
                device_id INTEGER NOT NULL,
                session_date TEXT NOT NULL,
                supervisor TEXT,
                notes TEXT,
                status TEXT DEFAULT 'completed',
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (group_id) REFERENCES training_groups(id),
                FOREIGN KEY (device_id) REFERENCES devices(id)
            )
        """)
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS surveys (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                device_id INTEGER,
                description TEXT,
                questions_json TEXT,
                is_active INTEGER DEFAULT 1,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (device_id) REFERENCES devices(id)
            )
        """)
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS survey_responses (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id INTEGER,
                survey_id INTEGER,
                participant_id INTEGER,
                responses_json TEXT,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (session_id) REFERENCES sessions(id),
                FOREIGN KEY (survey_id) REFERENCES surveys(id),
                FOREIGN KEY (participant_id) REFERENCES participants(id)
            )
        """)
        
        self.conn.commit()
    
    def insert_defaults(self):
        cursor = self.conn.cursor()
        
        devices = [
            (1, 'Hipoksi Eğitim Cihazı', 'HYPOXIA', '#F59E0B'),
            (2, 'SD Eğitim Cihazı', 'SD', '#8B5CF6'),
            (3, 'Gece Görüş Laboratuvarı', 'NVG', '#10B981'),
        ]
        
        for d in devices:
            cursor.execute("""
                INSERT OR IGNORE INTO devices (id, name, code, color) VALUES (?, ?, ?, ?)
            """, d)
        
        self.conn.commit()
    
    def get_all_participants(self):
        cursor = self.conn.cursor()
        cursor.execute("SELECT * FROM participants ORDER BY last_name, first_name")
        return [dict(row) for row in cursor.fetchall()]
    
    def add_participant(self, data: dict):
        cursor = self.conn.cursor()
        cursor.execute("""
            INSERT INTO participants (tc_no, first_name, last_name, title, branch, institution, email, phone, notes)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            data.get('tc_no'), data.get('first_name'), data.get('last_name'),
            data.get('title'), data.get('branch'), data.get('institution'),
            data.get('email'), data.get('phone'), data.get('notes')
        ))
        self.conn.commit()
        return cursor.lastrowid
    
    def update_participant(self, id: int, data: dict):
        cursor = self.conn.cursor()
        cursor.execute("""
            UPDATE participants SET 
                tc_no=?, first_name=?, last_name=?, title=?, branch=?,
                institution=?, email=?, phone=?, notes=?
            WHERE id=?
        """, (
            data.get('tc_no'), data.get('first_name'), data.get('last_name'),
            data.get('title'), data.get('branch'), data.get('institution'),
            data.get('email'), data.get('phone'), data.get('notes'), id
        ))
        self.conn.commit()
    
    def delete_participant(self, id: int):
        cursor = self.conn.cursor()
        cursor.execute("DELETE FROM participants WHERE id=?", (id,))
        self.conn.commit()
    
    def get_dashboard_stats(self):
        cursor = self.conn.cursor()
        stats = {}
        
        cursor.execute("SELECT COUNT(*) as c FROM participants")
        stats['total_participants'] = cursor.fetchone()['c']
        
        cursor.execute("SELECT COUNT(*) as c FROM training_groups WHERE status='active'")
        stats['active_groups'] = cursor.fetchone()['c']
        
        cursor.execute("SELECT COUNT(*) as c FROM sessions")
        stats['total_sessions'] = cursor.fetchone()['c']
        
        cursor.execute("""
            SELECT d.code, COUNT(s.id) as count
            FROM devices d
            LEFT JOIN sessions s ON d.id = s.device_id
            GROUP BY d.id
        """)
        stats['by_device'] = {row['code']: row['count'] for row in cursor.fetchall()}
        
        return stats


# ==================== QML BACKEND ====================

class Backend(QObject):
    """Backend for QML communication"""
    
    # Signals
    participantsChanged = Signal()
    statsChanged = Signal()
    
    def __init__(self, parent=None):
        super().__init__(parent)
        self.db = Database()
        self._participants = []
        self._stats = {}
        self.refresh()
    
    def refresh(self):
        self._participants = self.db.get_all_participants()
        self._stats = self.db.get_dashboard_stats()
        self.participantsChanged.emit()
        self.statsChanged.emit()
    
    # Properties
    @Property(list, notify=participantsChanged)
    def participants(self):
        return self._participants
    
    @Property('QVariant', notify=statsChanged)
    def stats(self):
        return self._stats
    
    # Slots
    @Slot(str, str, str, str, str, str, result=bool)
    def addParticipant(self, tc_no, first_name, last_name, title, branch, institution):
        try:
            self.db.add_participant({
                'tc_no': tc_no,
                'first_name': first_name,
                'last_name': last_name,
                'title': title,
                'branch': branch,
                'institution': institution
            })
            self.refresh()
            return True
        except Exception as e:
            print(f"Error adding participant: {e}")
            return False
    
    @Slot(int, result=bool)
    def deleteParticipant(self, id):
        try:
            self.db.delete_participant(id)
            self.refresh()
            return True
        except Exception as e:
            print(f"Error deleting participant: {e}")
            return False
    
    @Slot(result=int)
    def totalParticipants(self):
        return self._stats.get('total_participants', 0)
    
    @Slot(result=int)
    def totalSessions(self):
        return self._stats.get('total_sessions', 0)
    
    @Slot(result=int)
    def activeGroups(self):
        return self._stats.get('active_groups', 0)
    
    @Slot(str, result=int)
    def deviceSessionCount(self, device_code):
        return self._stats.get('by_device', {}).get(device_code, 0)


# ==================== MAIN ====================

def main():
    # High DPI support
    os.environ["QT_AUTO_SCREEN_SCALE_FACTOR"] = "1"
    
    app = QGuiApplication(sys.argv)
    app.setOrganizationName("Sağlık Bilimleri Üniversitesi")
    app.setOrganizationDomain("sbu.edu.tr")
    app.setApplicationName("HUFEM")
    
    # Create backend
    backend = Backend()
    
    # Create QML engine
    engine = QQmlApplicationEngine()
    
    # Add import paths
    qml_dir = Path(__file__).parent / "qml"
    engine.addImportPath(str(qml_dir))
    
    # Expose backend to QML
    engine.rootContext().setContextProperty("backend", backend)
    
    # Load main QML
    qml_file = qml_dir / "main.qml"
    engine.load(QUrl.fromLocalFile(str(qml_file)))
    
    if not engine.rootObjects():
        print("Error: Could not load QML file")
        sys.exit(-1)
    
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
