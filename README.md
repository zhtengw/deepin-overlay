# deepin-overlay

<atenzd@gmail.com>

It is a overlay built mainly for Deepin apps.
### Add the Overlay to your system
#### Option 1: Install by eselect repository
First emerge app-eselect/eselect-repository and dev-vcs/git:

     # emerge --ask --noreplace app-eselect/eselect-repository dev-vcs/git
     
Then add the overlay and sync:

     # eselect repository add deepin git https://github.com/zhtengw/deepin-overlay.git
     # emerge --sync deepin

#### Option 2: Install by layman
First emerge and configure layman, with the "**git**" USE flag enabled(see [Official Wiki](https://wiki.gentoo.org/wiki/Layman)).

Then add the deepin overlay:

     # layman -L && layman -a deepin

### Usage
With this Overlay, you can install the **Deepin Desktop Environment**([Installation Guide](https://github.com/zhtengw/deepin-overlay/wiki/Installing-Deepin-Desktop-Environment)), or just install some applications developed by Deepin Team(See [Applications List](https://github.com/zhtengw/deepin-overlay/wiki/Applications-From-Deepin-Team)).

### Note
Some packages of DDE are built with the private headers of Qt.

If your DDE is broken after you upgrade Qt version, please rebuild these packages:

     # emerge --oneshot --ask dde-base/dde-qt5integration dev-qt/qt5dxcb-plugin dev-qt/qtstyleplugins


### Packages list

* ***app-accessibility***
* |-onboard
* ***app-emulation***
* |-deepin-wine
* |-deepin-wine-helper
* ***dde-base***
* |-dde-account-faces
* |-dde-api
* |-dde-control-center
* |-dde-daemon
* |-dde-dock
* |-dde-file-manager
* |-dde-launcher
* |-dde-meta
* |-dde-network-utils
* |-dde-polkit-agent
* |-dde-qt-dbus-factory
* |-dde-qt5integration
* |-dde-session-ui
* |-deepin-anything
* |-deepin-desktop-base
* |-deepin-desktop-schemas
* |-deepin-file-manager-backend
* |-deepin-gettext-tools
* |-deepin-gtk-theme
* |-deepin-icon-theme
* |-deepin-menu
* |-deepin-sound-theme
* |-deepin-wallpapers
* |-dtkcore
* |-dtkwidget
* |-dtkwm
* |-startdde
* |-udisks2-qt5
* ***dde-extra***
* |-dde-calendar
* |-dde-file-manager-integration
* |-dde-introduction
* |-dde-meta-apps
* |-dde-meta-multimedia
* |-deepin-boot-maker
* |-deepin-calculator
* |-deepin-clone
* |-deepin-desktop-monitor
* |-deepin-editor
* |-deepin-font-installer
* |-deepin-grub2-themes
* |-deepin-manual
* |-deepin-picker
* |-deepin-screensaver
* |-deepin-shortcut-viewer
* |-deepin-system-monitor
* |-deepin-terminal
* |-deepin-topbar
* |-deepin-turbo
* |-plymouth-theme-deepin
* |-screensaver-pp
* ***media-sound***
* |-deepin-music
* |-deepin-voice-recorder
* ***media-video***
* |-deepin-movie-reborn
* ***media-gfx***
* |-blur-effect
* |-byzanz
* |-deepin-draw
* |-deepin-image-viewer
* |-deepin-screen-recorder
* |-deepin-screenshot
* ***dev-libs***
* |-granite
* ***dev-go***
* |-dbus-factory
* |-deepin-go-lib
* |-go-dbus-factory
* |-go-dbus-generator
* |-go-gir-generator
* |-go-x11-client
* ***x11-wm***
* |-dde-kwin
* |-deepin-metacity
* |-deepin-mutter
* |-deepin-wm
* ***virtual***
* |-dde-wm
* ***x11-libs***
* |-bamf
* |-gsettings-qt
* ***dev-qt***
* |-qcef
* |-qt5dxcb-plugin
* |-qtstyleplugins
* |-qtxcb-private-headers
* ***mail-client***
* |-deepin-wine-foxmail
* ***media-libs***
* |-cogl
* ***net-im***
* |-deepin-wine-QQ
* |-deepin-wine-QQ-Light
* |-deepin-wine-TIM
* |-deepin-wine-wechat
* |-deepin-wine-wechat-work
* ***net-misc***
* |-deepin-wine-thunderspeed
* ***x11-apps***
* |-xcur2png

