# GCDbar

Show your global cooldown as a bar.

![Screenshot of Addon](Capture.JPG)

## Issues

Doesn't handle no GCD spells. This is hard because:

- SPELLCAST_STOP doesn't tell use the spell name
- SPELLCAST_START does but we dont know if it does invoke GCD.
- Most list are incomplete e.g. https://www.wowhead.com/classic/spells?filter=116:21;2:4;0:11307#50 doesn't include mount spells?