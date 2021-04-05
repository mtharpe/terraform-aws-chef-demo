## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.web-01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route.internet_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_record.web-01](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.demo-tfe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_amis"></a> [aws\_amis](#input\_aws\_amis) | AWS AMI ID used for machine deployments | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to launch servers | `string` | `"us-east-2"` | no |
| <a name="input_chef_environment"></a> [chef\_environment](#input\_chef\_environment) | Chef Environment the machine will join | `string` | `"_default"` | no |
| <a name="input_chef_pem"></a> [chef\_pem](#input\_chef\_pem) | Chef PEM that is the match to the above defined Chef username | `any` | n/a | yes |
| <a name="input_chef_server_url"></a> [chef\_server\_url](#input\_chef\_server\_url) | Chef Server URL | `any` | n/a | yes |
| <a name="input_chef_username"></a> [chef\_username](#input\_chef\_username) | Chef Username that will be used to auth to Chef | `any` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Desired name of AWS key pair | `string` | `"terraform"` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | Private key info | `any` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | Public key info | `any` | n/a | yes |
| <a name="input_server_runlist"></a> [server\_runlist](#input\_server\_runlist) | Chef Runlist items | `string` | `"chef-linux-base-recipe::default"` | no |

## Outputs

No outputs.
