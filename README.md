# LayerVault Jekyll Plugins

Plugins that add extra LayerVault-specfic functionality to our public pages.

## Available Plugins

All plugins return a URL. You must build the HTML element yourself.

### Assets

``` liquid
# Asset Group/Asset.png in latest revision of File.psd
{% lv_asset "File.psd" "Group/Asset.png" %}
{% lv_asset "File.psd" "-" "Group/Asset.png" %}
# => https://layervault.com/organization/project/File.psd/assets/Group/Asset.png?raw=1

# Asset Group/Asset.png in revision 12 of File.psd
{% lv_asset "File.psd" "12" "Group/Asset.png" %}
# => https://layervault.com/organization/project/File.psd/revisions/12/assets/Group/Asset.png?raw=1
```

### Previews

``` liquid
# First preview in latest revision of File.psd
{% lv_preview "File.psd" %}
# => https://layervault.com/organization/project/File.psd/previews/1?raw=1

# 2nd preview of latest revision of File.psd
{% lv_preview "File.psd" "-" "2" %}
# => https://layervault.com/organization/project/File.psd/previews/2?raw=1

# First preview of 2nd revision of File.psd
{% lv_preview "File.psd" "2" %}
# => https://layervault.com/organization/project/File.psd/revisions/2/previews/1?raw=1

# 2nd preview of 3rd revision of File.psd
{% lv_preview "File.psd" "3" "2" %}
# => https://layervault.com/organization/project/File.psd/revisions/3/previews/2?raw=1
```

### Project

``` liquid
{% lv_project %}
# => https://layervault.com/organization/project
```

### Download

``` liquid
# Latest revision of File.psd
{% lv_download "File.psd" %}
# => https://layervault.com/organization/project/File.psd?raw=1

# 2nd revision of File.psd
{% lv_download "File.psd" "2" %}
# => https://layervault.com/organization/project/File.psd/revisions/2?raw=1
```
