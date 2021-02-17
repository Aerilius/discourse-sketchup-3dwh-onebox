discourse-sketchup-3dwh-onebox
=====================

It replaces links to 3D Warehouse models by a static preview image. 
When clicked, the image is replaced by the embed iframe showing the model in the webgl viewer.

## Installation

1. Install [discourse](https://github.com/discourse/discourse/blob/master/docs/DEVELOPER-ADVANCED.md).

2. Execute in the `discourse` root directory:

```bash
rake plugin:install repo=https://github.com/Aerilius/discourse-sketchup-3dwh-onebox.git name=sketchup_3dwh_onebox
rake assets:precompile
rake posts:rebake # this will take a long time.
# now restart your services
```

3. Add `https://3dwarehouse.sketchup.com` to your Discourse allowed iframes site setting.

## Deinstallation

```bash
rm -r plugins/sketchup_3dwh_onebox/
rake assets:precompile
rake posts:rebake
# now restart your services
```

