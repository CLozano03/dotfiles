hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata Modern Classic")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("MOZ_ENABLE_WAYLAND", "1")

hl.env("XDG_MENU_PREFIX", "arch-")

hl.env("HYPRSHOT_DIR", "$HOME/Pictures/Screenshots")

--# NVIDIA
-- This is from Hyprland Wiki. As a start, WLR_NO_HARDWARE_CURSORS 1 will be activated if nvidia gpu detected
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")

hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")
hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")
hl.env("WLR_DRM_NO_ATOMIC", "1")
hl.env("NVD_BACKEND", "direct")

-- FOR VM and POSSIBLY NVIDIA
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")

-- nvidia firefox (for hardware acceleration on FF)?
-- check this post https://github.com/elFarto/nvidia-vaapi-driver#configuration
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("NVD_BACKEND", "direct")
hl.env("EGL_PLATFORM", "wayland")

hl.env("LIBVA_DRIVER_NAME", "iHD")
