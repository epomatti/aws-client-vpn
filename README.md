# AWS Client VPN

Add the DNS entry to verify the VPN server certificate.

This repository uses **mutual authentication** architecture following AWS [guidelines][2].

### Generate the certificates

To start, clone the [easy-rsa][1] repository:

```sh
git clone https://github.com/OpenVPN/easy-rsa.git
```

Now trigger the PKI creation process:

```sh
bash scripts/generateCerts.sh
```

You'll be required to provide inputs to the script:

1. The CA common name, like `awsvpn.example.com`
2. `yes`
3. `yes`

The artifacts will be generated in the `./certs` directory.

### Provision the infrastructure

The generated certificates location is already referenced by the configuration.

Simply provision the infrastructure:

```sh
terraform init
terraform apply -auto-approve
```



[1]: https://github.com/OpenVPN/easy-rsa.git
[2]: https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/mutual.html