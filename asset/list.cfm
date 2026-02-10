<cfset assetModel = new model.Asset()>
<cfset assets = assetModel.getAll()>

<!DOCTYPE html>
<html>
<head>
    <title>Asset List</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/">Dashboard</a>
        <a href="/employee/list.cfm">Employees</a>
        <a href="/asset/list.cfm">Assets</a>
    </div>

    <div class="container">
        <div class="card">
            <div class="page-header">
                <h1>Asset List</h1>
                <div style="display: flex; gap: 10px;">
                    <input type="text" id="assetSearchBox" placeholder="Search assets..." style="padding: 8px; width: 200px;">
                    <a href="add.cfm" class="btn btn-success">+ Add Asset</a>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Asset Name</th>
                        <th>Serial</th>
                        <th>Assigned To</th>
                        <th>Dept</th>
                        <th>Date</th>
                        <th>Cost</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="assetTableBody">
                    <cfoutput query="assets">
                        <tr>
                            <td>#asset_name#</td>
                            <td>#serial_number#</td>
                            <td>#employee_name ?: 'Unassigned'#</td>
                            <td>#department ?: '-'#</td>
                            <td>#dateFormat(assigned_date, "mm/dd/yyyy")#</td>
                            <td>$#numberFormat(cost, "9,999.99")#</td>
                            <td>
                                <a href="edit.cfm?id=#id#" class="btn btn-primary btn-sm">Edit</a>
                                <a href="delete.cfm?id=#id#" class="btn btn-danger btn-sm" onclick="return confirm('Delete this asset?')">Delete</a>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const searchBox = document.getElementById('assetSearchBox');
        const tbody = document.getElementById('assetTableBody');

        searchBox.addEventListener('keyup', (e) => {
            const query = e.target.value;

            fetch(`/api/assets.cfm?q=${query}`)
                .then(response => response.json())
                .then(data => {
                    tbody.innerHTML = ''; 

                    if (data.length === 0) {
                        tbody.innerHTML = '<tr><td colspan="7" style="text-align:center; color: #999;">No assets found</td></tr>';
                    } else {
                        data.forEach(asset => {
                            const row = `
                                <tr>
                                    <td>${asset.name}</td>
                                    <td>${asset.serial}</td>
                                    <td>${asset.assigned_to}</td>
                                    <td>-</td> <td>-</td> <td>$${parseFloat(asset.cost).toFixed(2)}</td>
                                    <td>
                                        <a href="edit.cfm?id=${asset.id}" class="btn btn-primary btn-sm">Edit</a>
                                        <a href="delete.cfm?id=${asset.id}" class="btn btn-danger btn-sm" onclick="return confirm('Delete this asset?')">Delete</a>
                                    </td>
                                </tr>
                            `;
                            tbody.innerHTML += row;
                        });
                    }
                })
                .catch(error => console.error('Error:', error));
        });
    </script>
</body>
</html>