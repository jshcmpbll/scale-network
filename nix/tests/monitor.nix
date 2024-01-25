{ inputs, ... }:

{
  name = "monitor";

  nodes.machine1 = {
    _module.args = { inherit inputs; };
    imports = [ ../machines/monitor.nix ];
    virtualisation.graphics = true;
  };

  testScript = ''
    start_all()
    machine1.succeed("sleep 2")
    machine1.succeed("systemctl is-active grafana")
    machine1.wait_until_succeeds("nc -vz localhost 3000")
  '';
}
