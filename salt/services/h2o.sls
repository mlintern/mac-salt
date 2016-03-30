h2o:
  pkg.installed

h2o_plist:
  file.copy:
    - name: {{grains['homedir']}}/Library/LaunchAgents/homebrew.mxcl.h2o.plist
    - source: /usr/local/opt/h2o/homebrew.mxcl.h2o.plist
    - user: {{grains['user']}}
    - force: true
    - require:
      - pkg: h2o

h2o_conf:
  file.managed:
    - name: /usr/local/etc/h2o/h2o.conf 
    - source: salt://files/usr/local/etc/h2o/h2o.conf 
    - user: root
    - group: admin
    - mode: 644

h2o_setup_service:
  cmd.run:
    - name: launchctl load -w {{grains['homedir']}}/Library/LaunchAgents/homebrew.mxcl.h2o.plist
    - user: {{grains['user']}}
    - unless: launchctl list | grep homebrew.mxcl.h2o
    - require:
      - file: h2o_conf
      - file: h2o_plist