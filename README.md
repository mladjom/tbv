# TeamBox Vagrant (TBV)

## How To Use

To use it, download and install [Vagrant](https://www.vagrantup.com), [VirtualBox](https://www.virtualbox.org/) and [Git](https://git-scm.com/). Then, clone this repository and run:

```bash
vagrant plugin install vagrant-hostsupdater --local
```

```bash
vagrant up
```

For ssh access:
```bash
vagrant ssh
```
When it's done, visit http://tbv.test.

## Minimum System requirements

- [Vagrant](https://www.vagrantup.com) 2.2.4+
- [Virtualbox](https://www.virtualbox.org) 6.0.12
- [Git](https://git-scm.com/) 
- 8GB+ of RAM
- Virtualisation ( VT-X ) enabled in the BIOS ( Windows/Linux )
- Hyper-V turned off ( Windows )

## Software included

- Ubuntu 18.04 LTS (Bionic Beaver)
- Apache HTTP Server version 2.4
- PHP 7.2
- MySQL 5.7
- phpMyAdmin 
- Composer
- WP-CLI
- MailCatcher (TODO)

## Adding a New Site


### Apache
The Apache server is available at [192.168.33.10](http://192.168.33.10)

### MySQL
Externally the MySQL server is available at port 8889, and when running on the VM it is available as a socket or at port 3306 as usual.  
**Username**: root  
**Password**: toor

### PhpMyadmin
PhpMyadmin is available at [192.168.33.10/phpmyadmin](http://192.168.33.10/phpmyadmin)  
**Username**: root  
**Password**: toor


### Mailcatcher
Mailcatcher is available at [192.168.33.10:1080](http://192.168.33.10:1080)

## TODO

- Fake SMTP Server