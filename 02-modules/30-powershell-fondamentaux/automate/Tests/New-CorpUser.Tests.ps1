# Squelette Pester — à exécuter avec Invoke-Pester (nécessite un module AD mocké ou un lab).
Describe "New-CorpUser" {
  It "ne recrée pas un utilisateur existant (idempotence)" {
    # Exemple de structure : mock Get-ADUser pour renvoyer un objet, vérifier que New-ADUser n'est pas appelé.
    # Mock Get-ADUser { [pscustomobject]@{ sAMAccountName = 'test.user' } }
    # Mock New-ADUser {}
    # .\New-CorpUser.ps1 -Sam 'test.user' -DisplayName 'x' -OU 'OU=..' 
    # Assert-MockCalled New-ADUser -Times 0
    $true | Should -Be $true   # placeholder : compléter en lab
  }
}
