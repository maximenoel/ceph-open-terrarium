include:
  - repos

salt-minion-pkg:
  pkg.installed:
    - name: salt-minion

salt-minion-service:
  service.running:
    - name: salt-minion
    - enable: True
    - running: True
    - require:
      - pkg: salt-minion-pkg

master_configuration:
  file.managed:
    - name: /etc/salt/minion.d/master.conf
    - contents: |
        master: {{ pillar['deepsea-master-ip']}}
    - require:
      - pkg: salt-minion
