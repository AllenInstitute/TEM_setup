# TEM Setup

This is a repository containing files and instructions for setting up the microscope computers.

## Step 0: Modify BIOS

Go into the BIOS settings and turn on the Compatibility Support Module (CSM).

> This is only required for Asus ProArt z790 motherboards.

## Step 1: Install Ubuntu

Install [Ubuntu 22.04](https://releases.ubuntu.com/22.04/ubuntu-22.04.5-desktop-amd64.iso) using a USB drive.

The Hostname should be set to `TEM$i` where `$i` is the TEM number.

The following partitions should be created:

#### 1 TB Drive

| Size      | Type           | Mountpoint |
| --------- | -------------- | ---------- |
| 500 MB    | EFI            |            |
| 10 MB     | BIOS Boot Area |            |
| Remaining | ext4           | /          |

#### 4 TB Drive

| Size      | Type | Mountpoint |
| --------- | ---- | ---------- |
| Remaining | ext4 | /storage   |

## Step 2: Bootstrap Setup

In a terminal run:

```bash
wget https://raw.githubusercontent.com... | sudo sh
