<#
.SYNOPSIS  Affiche l'arbre des processus (PID/parent/ligne de commande). Lecture seule.
#>
[CmdletBinding()] param()
$procs = Get-CimInstance Win32_Process | Select ProcessId, ParentProcessId, Name, CommandLine
function Show-Tree($ppid, $indent) {
  $procs | Where-Object ParentProcessId -eq $ppid | ForEach-Object {
    "{0}{1} ({2})" -f (' ' * $indent), $_.Name, $_.ProcessId
    if ($_.CommandLine) { "{0}   cmd: {1}" -f (' ' * $indent), $_.CommandLine.Trim() }
    Show-Tree $_.ProcessId ($indent + 2)
  }
}
# Racines (parent absent)
$procs | Where-Object { $_.ParentProcessId -eq 0 -or -not ($procs.ProcessId -contains $_.ParentProcessId) } |
  ForEach-Object { "{0} ({1})" -f $_.Name, $_.ProcessId; Show-Tree $_.ProcessId 2 }
