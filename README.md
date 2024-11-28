## This is sample devops project repo
## How to setup CICD pipeline using Github Actions?
1. Create a folder `.github/workflows`
```bash
   mkdir -p .github/workflows
```
2. Push to new origin

![RPC Status](https://img.shields.io/endpoint?url=https://github.com/devops-new-world/DevOps930/actions/workflows/rpc_status.yml)

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RPC Endpoint Status</title>
    <style>
        .badge {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <h1>RPC Endpoint Status</h1>

    <div id="badges">
        <div class="badge" id="icon-status">Checking ICON...</div>
        <div class="badge" id="archway-status">Checking Archway...</div>
        <div class="badge" id="bsc-status">Checking BSC...</div>
        <div class="badge" id="centauri-status">Checking Centauri...</div>
        <div class="badge" id="stellar-status">Checking Stellar...</div>
        <div class="badge" id="sui-status">Checking SUI...</div>
        <div class="badge" id="ethereum-status">Checking Ethereum...</div>
        <div class="badge" id="solana-status">Checking Solana...</div>
        <div class="badge" id="stack-status">Checking Stacks...</div>
    </div>

    <script>
        // Array of RPC endpoints
        const endpoints = {
            "ICON": "https://tt.net.solidwallet.io/jvm-rpc/api/v3",
            "Archway": "https://tt.net.solidwallet.io/cosmwasm-rpc/",
            "BSC": "https://tt.net.solidwallet.io/bsc-rpc/",
            "Centauri": "https://tt.net.solidwallet.io/centauri-rpc/",
            "Stellar": "https://tt.net.solidwallet.io/stellar-rpc",
            "SUI": "https://tt.net.solidwallet.io/sui-rpc",
            "Ethereum": "https://tt.net.solidwallet.io/hardhat-rpc/",
            "Solana": "https://solana-rpc.venture23.xyz",
            "Stacks": "https://tt.net.solidwallet.io/stacks-api"
        };

        // Function to check the status of an endpoint
        async function checkStatus(url) {
            try {
                let response = await fetch(url, { method: 'HEAD' }); // HEAD request to check status
                return response.ok ? 'up' : 'down'; // Return status based on response
            } catch (error) {
                return 'down'; // Return 'down' if there's an error
            }
        }

        // Function to update the badge based on the status
        async function updateBadge(endpointName, url) {
            const status = await checkStatus(url);
            const badgeColor = status === 'up' ? 'green' : 'red'; // Green for up, red for down
            const badgeUrl = `https://img.shields.io/badge/${endpointName}-${status}-${badgeColor}`;

            // Update the badge in the HTML
            document.getElementById(`${endpointName.toLowerCase()}-status`).innerHTML = `
                <strong>${endpointName}:</strong> 
                <img src="${badgeUrl}" alt="${endpointName} status">
            `;
        }

        // Function to check all endpoints and update the badges
        async function checkAllEndpoints() {
            for (const [name, url] of Object.entries(endpoints)) {
                await updateBadge(name, url);
            }
        }

        // Call the function to check the endpoints and render badges
        checkAllEndpoints();
    </script>
</body>
</html>
