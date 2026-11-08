{ theme, themeUtils, ... }:
let
  hexRGBstr = hex-code: themeUtils.RGBStringSep "," (themeUtils.hexToRGB hex-code);
  attrHexRGBstr = builtins.mapAttrs (_: hex-code: hexRGBstr hex-code);
  colors = {
    accent = hexRGBstr theme.colors.accent;
    text = attrHexRGBstr theme.colors.text;
    colors = attrHexRGBstr theme.colors.colors;
    colors_variant = attrHexRGBstr theme.colors.colors_variant;
    backgrounds = attrHexRGBstr theme.colors.backgrounds;
  };

  title_bar = {
    active = {
      background = colors.backgrounds.base;
      text = colors.text.primary;
      secondary = colors.text.subtle;
    };
    inactive = {
      background = colors.backgrounds.overlay;
      text = colors.text.subtle;
      secondary = colors.text.muted;
    };
  };
  header = {
    background = colors.backgrounds.base;
    text = colors.text.primary;
  };
  window = {
    background = colors.backgrounds.base;
    text = colors.text.primary;
  };
  view = {
    background = colors.backgrounds.surface;
    text = colors.text.primary;
  };
  tooltip = {
    background = colors.backgrounds.overlay;
    text = colors.text.subtle;
  };
  button = {
    background = colors.backgrounds.highlight_med;
    text = colors.text.primary;
  };
  selection = {
    background = colors.accent;
    text = colors.text.primary;
  };
  focus = {
    hover = colors.accent;
    active = themeUtils.RGBStringSep "," (
      themeUtils.darkenRGB 0.2 (themeUtils.hexToRGB theme.colors.accent)
    );
  };
  generic-colors = {
    text = {
      normal = colors.text.primary;
      link = colors.colors.blue;
      visited = colors.colors.purple;
      active = colors.colors_variant.blue;
      inactive = colors.text.muted;
      negative = colors.colors.red;
      neutral = colors.colors.orange;
      positive = colors.colors.green;
    };
    background = {
      normal = colors.backgrounds.base;
      alternate = colors.backgrounds.overlay;
    };
  };
  accent = colors.accent;
in
{
  "General" = {
    AccentColor = accent;
    LastUsedCustomAccentColor = accent;
  };
  "Colors:Button" = {
    BackgroundAlternate = generic-colors.background.alternate;
    BackgroundNormal = button.background;
    DecorationFocus = focus.active;
    DecorationHover = focus.hover;
    ForegroundActive = generic-colors.text.active;
    ForegroundInactive = generic-colors.text.inactive;
    ForegroundLink = generic-colors.text.link;
    ForegroundNegative = generic-colors.text.negative;
    ForegroundNeutral = generic-colors.text.neutral;
    ForegroundNormal = button.text;
    ForegroundPositive = generic-colors.text.positive;
    ForegroundVisited = generic-colors.text.visited;
  };
  "Colors:Complementary" = {
    BackgroundAlternate = generic-colors.background.alternate;
    BackgroundNormal = generic-colors.background.normal;
    DecorationFocus = focus.active;
    DecorationHover = focus.hover;
    ForegroundActive = generic-colors.text.active;
    ForegroundInactive = generic-colors.text.inactive;
    ForegroundLink = generic-colors.text.link;
    ForegroundNegative = generic-colors.text.negative;
    ForegroundNeutral = generic-colors.text.neutral;
    ForegroundNormal = generic-colors.text.normal;
    ForegroundPositive = generic-colors.text.positive;
    ForegroundVisited = generic-colors.text.visited;
  };
  "Colors:Header" = {
    BackgroundAlternate = generic-colors.background.alternate;
    BackgroundNormal = header.background;
    DecorationFocus = focus.active;
    DecorationHover = focus.hover;
    ForegroundActive = generic-colors.text.active;
    ForegroundInactive = generic-colors.text.inactive;
    ForegroundLink = generic-colors.text.link;
    ForegroundNegative = generic-colors.text.negative;
    ForegroundNeutral = generic-colors.text.neutral;
    ForegroundNormal = header.text;
    ForegroundPositive = generic-colors.text.positive;
    ForegroundVisited = generic-colors.text.visited;
  };
  "Colors:Header/Inactive" = {
    BackgroundAlternate = generic-colors.background.alternate;
    BackgroundNormal = window.background;
    DecorationFocus = focus.active;
    DecorationHover = focus.hover;
    ForegroundActive = generic-colors.text.active;
    ForegroundInactive = generic-colors.text.inactive;
    ForegroundLink = generic-colors.text.link;
    ForegroundNegative = generic-colors.text.negative;
    ForegroundNeutral = generic-colors.text.neutral;
    ForegroundNormal = header.text;
    ForegroundPositive = generic-colors.text.positive;
    ForegroundVisited = generic-colors.text.visited;
  };
  "Colors:Selection" = {
    BackgroundAlternate = generic-colors.background.alternate;
    BackgroundNormal = selection.background;
    DecorationFocus = focus.active;
    DecorationHover = focus.hover;
    foregroundactive = generic-colors.text.active;
    foregroundinactive = generic-colors.text.inactive;
    foregroundlink = generic-colors.text.link;
    foregroundnegative = generic-colors.text.negative;
    foregroundneutral = generic-colors.text.neutral;
    foregroundnormal = selection.text;
    foregroundpositive = generic-colors.text.positive;
    foregroundvisited = generic-colors.text.visited;
  };
  "Colors:Tooltip" = {
    BackgroundAlternate = generic-colors.background.alternate;
    BackgroundNormal = tooltip.background;
    DecorationFocus = focus.active;
    DecorationHover = focus.hover;
    foregroundactive = generic-colors.text.active;
    foregroundinactive = generic-colors.text.inactive;
    foregroundlink = generic-colors.text.link;
    foregroundnegative = generic-colors.text.negative;
    foregroundneutral = generic-colors.text.neutral;
    foregroundnormal = tooltip.text;
    foregroundpositive = generic-colors.text.positive;
    foregroundvisited = generic-colors.text.visited;
  };
  "Colors:View" = {
    BackgroundAlternate = generic-colors.background.alternate;
    BackgroundNormal = view.background;
    DecorationFocus = focus.active;
    DecorationHover = focus.hover;
    foregroundactive = generic-colors.text.active;
    foregroundinactive = generic-colors.text.inactive;
    foregroundlink = generic-colors.text.link;
    foregroundnegative = generic-colors.text.negative;
    foregroundneutral = generic-colors.text.neutral;
    foregroundnormal = view.text;
    foregroundpositive = generic-colors.text.positive;
    foregroundvisited = generic-colors.text.visited;
  };
  "Colors:Window" = {
    BackgroundAlternate = generic-colors.background.alternate;
    BackgroundNormal = window.background;
    DecorationFocus = focus.active;
    DecorationHover = focus.hover;
    foregroundactive = generic-colors.text.active;
    foregroundinactive = generic-colors.text.inactive;
    foregroundlink = generic-colors.text.link;
    foregroundnegative = generic-colors.text.negative;
    foregroundneutral = generic-colors.text.neutral;
    foregroundnormal = window.text;
    foregroundpositive = generic-colors.text.positive;
    foregroundvisited = generic-colors.text.visited;
  };
  "WM" = {
    activeBackground = title_bar.active.background;
    activeBlend = title_bar.active.text;
    activeForeground = title_bar.active.secondary;
    inactiveBackground = title_bar.inactive.background;
    inactiveBlend = title_bar.inactive.text;
    inactiveForeground = title_bar.inactive.secondary;
  };
}
