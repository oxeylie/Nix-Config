{ super }:
super.sketchybar.overrideAttrs (oldAttrs: {
  postPatch =
    (oldAttrs.postPatch or "") # Patch for macOS 27.2
    + ''
      substituteInPlace src/bar_manager.c \
            		--replace-fail "bar_manager->window_level = kCGStatusWindowLevel;" \
            		"bar_manager->window_level = kCGPopUpMenuWindowLevel;" '';
})
