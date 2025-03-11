provider "google" {
  project = var.project_name
  region  = var.region_name
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = "asia-south2-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = var.network_interface
    access_config {
    }
  }

  metadata = {
    startup-script = file("init.sh")
    ssh-keys = "${var.ssh_user}:${var.ssh_key}"
  }
  tags = ["psql-vm"]

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  labels = {
    environment = "dev"
  }
}

resource "google_compute_firewall" "allow_postgres" {
  name    = "allow-postgres"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["psql-vm"]
}
