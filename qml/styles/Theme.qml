pragma Singleton
import QtQuick

QtObject {
    // ==================== COLORS ====================
    // Primary Brand
    readonly property color primary: "#6366F1"
    readonly property color primaryDark: "#4F46E5"
    readonly property color primaryLight: "#818CF8"
    readonly property color primaryFaded: "#EEF2FF"
    
    // Secondary
    readonly property color secondary: "#0EA5E9"
    readonly property color secondaryDark: "#0284C7"
    
    // Device Colors
    readonly property color hypoxia: "#F59E0B"
    readonly property color hypoxiaLight: "#FEF3C7"
    readonly property color sd: "#8B5CF6"
    readonly property color sdLight: "#EDE9FE"
    readonly property color nvg: "#10B981"
    readonly property color nvgLight: "#D1FAE5"
    
    // Status
    readonly property color success: "#22C55E"
    readonly property color successLight: "#DCFCE7"
    readonly property color warning: "#F59E0B"
    readonly property color warningLight: "#FEF3C7"
    readonly property color error: "#EF4444"
    readonly property color errorLight: "#FEE2E2"
    readonly property color info: "#3B82F6"
    readonly property color infoLight: "#DBEAFE"
    
    // Neutrals
    readonly property color white: "#FFFFFF"
    readonly property color gray50: "#F9FAFB"
    readonly property color gray100: "#F3F4F6"
    readonly property color gray200: "#E5E7EB"
    readonly property color gray300: "#D1D5DB"
    readonly property color gray400: "#9CA3AF"
    readonly property color gray500: "#6B7280"
    readonly property color gray600: "#4B5563"
    readonly property color gray700: "#374151"
    readonly property color gray800: "#1F2937"
    readonly property color gray900: "#111827"
    
    // Backgrounds
    readonly property color bgMain: "#F8FAFC"
    readonly property color bgCard: "#FFFFFF"
    readonly property color bgSidebar: "#1E293B"
    readonly property color bgSidebarHover: "#334155"
    readonly property color bgSidebarActive: "#6366F1"
    
    // ==================== TYPOGRAPHY ====================
    readonly property int fontTiny: 10
    readonly property int fontSmall: 12
    readonly property int fontNormal: 14
    readonly property int fontMedium: 16
    readonly property int fontLarge: 20
    readonly property int fontXLarge: 24
    readonly property int fontHuge: 32
    readonly property int fontGiant: 48
    
    readonly property string fontFamily: "Segoe UI"
    
    // ==================== SPACING ====================
    readonly property int spacingXS: 4
    readonly property int spacingS: 8
    readonly property int spacingM: 12
    readonly property int spacingL: 16
    readonly property int spacingXL: 24
    readonly property int spacingXXL: 32
    readonly property int spacingHuge: 48
    
    // ==================== RADIUS ====================
    readonly property int radiusS: 6
    readonly property int radiusM: 8
    readonly property int radiusL: 12
    readonly property int radiusXL: 16
    readonly property int radiusRound: 9999
    
    // ==================== SHADOWS ====================
    readonly property color shadowColor: "#1A000000"
    readonly property color shadowColorLight: "#0D000000"
    
    // ==================== ANIMATION ====================
    readonly property int animFast: 150
    readonly property int animNormal: 250
    readonly property int animSlow: 400
    
    // ==================== SIDEBAR ====================
    readonly property int sidebarWidth: 260
    readonly property int sidebarCollapsedWidth: 72
}
