#!/bin/bash
      sudo apt-get update -y
      sudo apt-get install postgresql docker.io -y
      sudo sed -i 's/^#\?listen_addresses =.*/listen_addresses = '\''*'\''/' /etc/postgresql/14/main/postgresql.conf
      echo "host all all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/14/main/pg_hba.conf
      sudo systemctl restart postgresql

      cd ~ && sudo -u postgres psql --db postgres << EOF
CREATE ROLE vinamrgrover WITH LOGIN SUPERUSER PASSWORD 'SHINchan123';
ALTER ROLE vinamrgrover WITH LOGIN;
EOF

