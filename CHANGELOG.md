# Changelog

## 1.2.1

- Fixed: the minimum time between switches did not work. Every switch reloads the UI, which reset the timer, so only a 2 second grace period applied after each reload. The time of the last switch is now saved and survives the reload. The time is counted from the switch, so it includes the loading screen.

## 1.2.0

- Localization: the addon follows the game language. Included: German, Spanish (Spain and Mexico), French, Italian, Korean, Brazilian Portuguese, Russian, Simplified Chinese and Traditional Chinese. Anything without a translation falls back to English.
- Localized descriptions in the AddOns list.
- Panel buttons widen to fit longer translations.

## 1.1.0

- Minimap button showing the current mode. Left-click switches now, right-click opens the options, drag to move it.
- Controller and keyboard icons, also shown in the AddOns list.
- New option and `/inputswap minimap` to show or hide the button.

## 1.0.0

- First release.
- Left stick switches to the Gamepad UI. Movement keys switch back to the mouse and keyboard UI.
- Options panel under Options > AddOns > InputSwap.
- Combat handling: ignore input during combat, or switch once combat ends.
- Configurable minimum time between switches.
- Slash commands with `/inputswap help`, plus debug tools.
