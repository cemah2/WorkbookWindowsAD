#!/usr/bin/env python3
"""Génère un inventaire Ansible (YAML) à partir des outputs Terraform (JSON).
Usage : python3 gen_inventory.py tf_outputs.json > inventory.yml
Hypothèse : des outputs 'dc_hosts' et 'member_hosts' (listes de FQDN) existent.
Adapter aux outputs réels de ton code Terraform (module 34)."""
import json, sys

def main(path):
    data = json.load(open(path, encoding="utf-8"))
    dcs = data.get("dc_hosts", {}).get("value", [])
    members = data.get("member_hosts", {}).get("value", [])
    print("all:")
    print("  children:")
    print("    domaincontrollers:")
    print("      hosts:")
    for h in dcs:
        print(f"        {h}:")
    print("    members:")
    print("      hosts:")
    for h in members:
        print(f"        {h}:")
    print("  vars:")
    print("    ansible_connection: winrm")
    print("    ansible_winrm_transport: kerberos")
    print("    ansible_port: 5985")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("usage: gen_inventory.py tf_outputs.json")
    main(sys.argv[1])
