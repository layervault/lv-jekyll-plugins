# LayerVault Jekyll Plugins

Plugins that add extra LayerVault-specfic functionality to our public pages.

## Available Plugins

### Assets

``` liquid
# Asset Group/Asset.png in latest revision of File.psd
{% lv_asset "File.psd" "Group/Asset.png" %}
# => https://layervault.com/organization/project/File.psd/assets/Group/Asset.png`

# Asset Group/Asset.png in revision 12 of File.psd
{% lv_asset "File.psd" "12" "Group/Asset.png" %}
# => https://layervault.com/organization/project/File.psd/revisions/12/assets/Group/Asset.png
```
