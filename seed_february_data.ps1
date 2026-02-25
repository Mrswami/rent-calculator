$apiKey = "AIzaSyDrhe_jNTXrGF1xiclVPXWAuztRAglGXuM"
$projectId = "rent-calculator-bedd3"

# Jacob's email to find UID (actually we can just write to the collections)
# But wait, the app structure uses:
# /utility_bills/{year}/{month}/... or just a flat collection?
# Let's check FirebaseService.getUtilityBills

# FirebaseService.dart shows:
# return _firestore.collection('utility_bills')
#    .where('month', isEqualTo: month)
#    .where('year', isEqualTo: year)

$url = "https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/utility_bills?key=$apiKey"

$febDate = "2026-02-01T00:00:00Z"
$dueDate = "2026-02-15T00:00:00Z"

# 1. Building Bill (Rent + Fees)
$buildingBill = @{
    fields = @{
        name = @{ stringValue = "February Building Bill" }
        category = @{ stringValue = "rent" }
        totalAmount = @{ doubleValue = 2030.99 }
        month = @{ integerValue = 2 }
        year = @{ integerValue = 2026 }
        dueDate = @{ timestampValue = $dueDate }
        notes = @{ stringValue = "Auto-filled from ResMan screenshot" }
        lineItems = @{
            arrayValue = @{
                values = @(
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Rent" }; amount = @{ doubleValue = 1803.0 }; isWeighted = @{ booleanValue = $false } } } },
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Resident Services" }; amount = @{ doubleValue = 97.0 }; isWeighted = @{ booleanValue = $false } } } },
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Wi-Fi" }; amount = @{ doubleValue = 70.0 }; isWeighted = @{ booleanValue = $false } } } },
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Smart Home" }; amount = @{ doubleValue = 40.0 }; isWeighted = @{ booleanValue = $false } } } },
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "CAM Fee" }; amount = @{ doubleValue = 12.0 }; isWeighted = @{ booleanValue = $false } } } },
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Trash Admin" }; amount = @{ doubleValue = 3.0 }; isWeighted = @{ booleanValue = $false } } } },
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Jacob Credit Builder" }; amount = @{ doubleValue = 5.99 }; isWeighted = @{ booleanValue = $true } } } }
                )
            }
        }
        splits = @{
            arrayValue = @{
                values = @(
                    # Jacob (1/4th of 2025 + 5.99)
                    @{ mapValue = @{ fields = @{ userName = @{ stringValue = "Jacob" }; weight = @{ doubleValue = 0.25 }; amount = @{ doubleValue = 512.24 }; isPaid = @{ booleanValue = $false } } } },
                    # Eddy (1/4th of 2025)
                    @{ mapValue = @{ fields = @{ userName = @{ stringValue = "Eddy" }; weight = @{ doubleValue = 0.25 }; amount = @{ doubleValue = 506.25 }; isPaid = @{ booleanValue = $false } } } },
                    # Nico (1/2 of 2025)
                    @{ mapValue = @{ fields = @{ userName = @{ stringValue = "Nico" }; weight = @{ doubleValue = 0.50 }; amount = @{ doubleValue = 1012.50 }; isPaid = @{ booleanValue = $false } } } }
                )
            }
        }
    }
}

# 2. Utility Bill (Electric + Fees)
$utilityBill = @{
    fields = @{
        name = @{ stringValue = "February Utilities" }
        category = @{ stringValue = "electricity" }
        totalAmount = @{ doubleValue = 303.23 }
        month = @{ integerValue = 2 }
        year = @{ integerValue = 2026 }
        dueDate = @{ timestampValue = $dueDate }
        notes = @{ stringValue = "Auto-filled from Austin Energy screenshot (includes $200 deposit)" }
        lineItems = @{
            arrayValue = @{
                values = @(
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Electric Usage" }; amount = @{ doubleValue = 76.41 }; isWeighted = @{ booleanValue = $true } } } },
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Anti-litter" }; amount = @{ doubleValue = 10.25 }; isWeighted = @{ booleanValue = $false } } } },
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Transportation Fee" }; amount = @{ doubleValue = 16.57 }; isWeighted = @{ booleanValue = $false } } } },
                    @{ mapValue = @{ fields = @{ description = @{ stringValue = "Other (Deposit)" }; amount = @{ doubleValue = 200.0 }; isWeighted = @{ booleanValue = $false } } } }
                )
            }
        }
        splits = @{
            arrayValue = @{
                values = @(
                    # Jacob (50% electric + 1/3 fees)
                    @{ mapValue = @{ fields = @{ userName = @{ stringValue = "Jacob" }; weight = @{ doubleValue = 1.0 }; amount = @{ doubleValue = 113.82 }; isPaid = @{ booleanValue = $false } } } },
                    # Eddy (25% electric + 1/3 fees)
                    @{ mapValue = @{ fields = @{ userName = @{ stringValue = "Eddy" }; weight = @{ doubleValue = 0.5 }; amount = @{ doubleValue = 94.71 }; isPaid = @{ booleanValue = $false } } } },
                    # Nico (25% electric + 1/3 fees)
                    @{ mapValue = @{ fields = @{ userName = @{ stringValue = "Nico" }; weight = @{ doubleValue = 0.5 }; amount = @{ doubleValue = 94.71 }; isPaid = @{ booleanValue = $false } } } }
                )
            }
        }
    }
}

Write-Host "Seeding February Data..." -ForegroundColor Cyan

Invoke-RestMethod -Uri $url -Method Post -Body ($buildingBill | ConvertTo-Json -Depth 10) -ContentType "application/json" | Out-Null
Invoke-RestMethod -Uri $url -Method Post -Body ($utilityBill | ConvertTo-Json -Depth 10) -ContentType "application/json" | Out-Null

Write-Host "Done! February bills seeded successfully." -ForegroundColor Green
