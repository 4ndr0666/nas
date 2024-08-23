# System Configuration

## Hard Drive Layout

### `sda`: 465.8G
- **`sda1`**: 465.3G
  - **File System**: ext4
  - **Label**: 4ndr0
  - **UUID**: 656f1c92-4f80-4257-a037-4216a32c05da

### `sdb`: 1.8T
- **`sdb1`**: 1.4T
  - **File System**: ext4
  - **Label**: 23.1
  - **UUID**: 87dc0c12-7b18-4bc1-bdc2-7040e50829c2
- **`sdb5`**: 418G
  - **File System**: btrfs
  - **Label**: Nas
  - **UUID**: e37c9f79-0631-4ebd-8437-922e9733caee
  - **Mount Point**: /run/media/liveuser/Nas

### `sdc`: 465.8G
- **`sdc1`**: 4.7G
  - **File System**: vfat
  - **Label**: BOOT
  - **UUID**: 8E59-3341
- **`sdc2`**: 7.7G
  - **File System**: swap
  - **UUID**: d755bc3e-41c3-473e-a7bd-0a4131de70e8
- **`sdc3`**: 205.8G
  - **File System**: btrfs
  - **Label**: garuda-hypr
  - **UUID**: d1d41ea2-e482-44ec-9c38-93997c0114c0
  - **Mount Point**: /run/media/root/garuda-hypr
- **`sdc4`**: 247.5G
  - **File System**: ext4
  - **Label**: Storage
  - **UUID**: 42c2a048-4a1d-4d60-a7cb-a72294fcb32b

### `sdd`: 931.5G
- **`sdd1`**: 4.7G
  - **File System**: vfat
  - **Label**: BOOT
  - **UUID**: E495-B8FE
- **`sdd2`**: 41.9G
  - **File System**: ext4
  - **UUID**: 5e088995-c915-4411-a92d-247c696b29cb
- **`sdd3`**: 307.3G
  - **File System**: btrfs
  - **Label**: way
  - **UUID**: 625890c0-740c-42f7-aced-517200ea7f7a
  - **Mount Points**:
    - /mnt/dev/@log
    - /mnt/dev/@home
    - /mnt/dev/@cache
    - /mnt/dev

### `sde`: 57.3G
- **`sde1`**: 57.3G
  - **File System**: exfat
  - **Label**: 4ndr0666
  - **UUID**: 18F1-6A28
  - **Subvolume**: ventoy
    - **File System**: iso9660
    - **Label**: ARCHCRAFT_202401
    - **UUID**: 2024-01-09-05-41-01-00
    - **Mount Point**: /run/archiso/bootmnt
- **`sde2`**: 32M
  - **File System**: vfat
  - **Label**: VTOYEFI
  - **UUID**: 3F32-27F5

## Operating System and Boot Drives
- **Main OS Drive**: `/dev/sdd3` (btrfs, with multiple subvolumes mounted at /mnt/dev)
- **Boot Partition**: `/dev/sdd1` (vfat)
- **Additional OS**: Garuda Linux on `/dev/sdc3` (btrfs)

## Backups
- **Backup Location**: Backups are being sent to `/run/media/liveuser/Nas/Backups` on the `sdb5` partition (btrfs, label: Nas).
