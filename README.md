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

### Setting the Profile, USE flags, KEYWORDS and Updating
First enable testing architectures. 
Set **ACCEPT_KEYWORDS="~amd64"** in **/etc/portage/make.conf** (or **ACCEPT_KEYWORDS="~x86"** if your architecture is x86).

Then set your system to use the proper profile and USE flags.
#### For OpenRC user:
Using the basic "desktop" profile

     # eselect profile set default/linux/amd64/17.0/desktop
     
Add "**elogind**" USE flag in **/etc/portage/make.conf**, it's also recommended to disable support for other session trackers to avoid conflicts:

***/etc/portage/make.conf***
```
USE="elogind -consolekit -systemd"
```
#### For Systemd user:
Using the "systemd" profile

     # eselect profile set default/linux/amd64/17.0/systemd
     
Add "**X**" USE flag in **/etc/portage/make.conf**.

After setting, remerge @world so the changes take effect: 

     # emerge --deep --with-bdeps=y --changed-use --update --ask --verbose @world 

### Emerging Deepin Desktop Environment

     # emerge --ask --verbose --keep-going dde-base/dde-meta

### Configuring and Running DDE
Assuming that you have setup X11 properly, now going to configure DDE.

Configuring lightdm greeter: 

There are two greeter we can choose -- **lightdm-gtk-greeter** and **lightdm-deepin-greeter**. But **lightdm-deepin-greeter** runs abnormally without systemd, so we use lightdm-gtk-greeter by default.

***/etc/lightdm/lightdm.conf***
```
greeter-session=lightdm-gtk-greeter
```

#### For OpenRC user:
Emerging **x11-apps/xdm** and Changing the **DISPLAYMANGER** value in the xdm configuration file to use **lightdm**.

***/etc/conf.d/xdm***
```
DISPLAYMANAGER="lightdm"
```
Set **dbus**, **xdm**, **NetworkManager** and **elogind** to come up on boot, and disable **dhcpcd** if you have enabled it.
     
     # rc-update add dbus default 
     # rc-update add xdm default 
     # rc-update add NetworkManager default 
     # rc-update del dhcpcd default 
     # rc-update add elogind boot 

Start up DDE
     
     # openrc

#### For Systemd user:
Enable **NetworkManager**, **lightdm** to be started at boot time.
     
     # systemctl enable NetworkManager
     # systemctl enable lightdm

Start up and login:

     # systemctl start NetworkManager
     # systemctl start lightdm

### Note
Some packages of DDE are built with the private headers of Qt.

If your DDE is broken after you upgrade Qt version, please rebuild these packages:

     # emerge --oneshot --ask dde-base/dde-qt5integration dev-qt/qt5dxcb-plugin dev-qt/qtstyleplugins


### Packages list

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
* |-deepin-artwork-themes
* |-deepin-desktop-base
* |-deepin-desktop-schemas
* |-deepin-file-manager-backend
* |-deepin-gettext-tools
* |-deepin-gtk-theme
* |-deepin-icon-theme
* |-deepin-menu
* |-deepin-sound-theme
* |-deepin-wallpapers
* |-deepin-wm-switcher
* |-dtksettings
* |-dtkcore
* |-dtkwidget
* |-dtkwm
* |-startdde
* |-udisks2-qt5
* ***dde-extra***
* |-dde-calendar
* |-dde-file-manager-integration
* |-dde-help
* |-dde-introduction
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
* |-deepin-qml-widgets
* |-deepin-shortcut-viewer
* |-deepin-social-sharing
* |-deepin-system-monitor
* |-deepin-terminal
* |-deepin-topbar
* |-deepin-turbo
* |-plymouth-theme-deepin
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
* |-deepin-metacity
* |-deepin-mutter
* |-deepin-wm
* ***x11-libs***
* |-bamf
* |-gsettings-qt
* ***dev-cpp***
* |-treefrog-framework
* ***dev-perl***
* |-XML-LibXML-PrettyPrint
* ***dev-qt***
* |-qcef
* |-qt5dxcb-plugin
* |-qtstyleplugins
* |-qtxcb-private-headers
* ***media-libs***
* |-cogl
* ***net-im***
* |-deepin-wine-QQ
* |-deepin-wine-wechat
* ***x11-apps***
* |-xcur2png

