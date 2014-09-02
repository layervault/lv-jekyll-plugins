# LayerVault Jekyll Plugins

Plugins that add extra LayerVault-specfic functionality to our public pages.

## Available Plugins

### Previews

<table>
  <thead>
    <td>Jekyll Tag</td>
    <td>Output</td>
  </thead>
  <tr>
    <td>`{% lv_asset "File.psd" "Group/Asset.png" %}`</td>
    <td>`https://layervault.com/organization/project/File.psd/assets/Group/Asset.png`</td>
  </tr>
  <tr>
    <td>`{% lv_asset "File.psd" "12" "Group/Asset.png" %}`</td>
    <td>`https://layervault.com/organization/project/File.psd/revisions/12/assets/Group/Asset.png`</td>
  </tr>
    <td>
  </tr>
</table>
