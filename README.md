# Container: Vagrant

[![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=popout-square)](licence)

## Description

Vagrant container where OpenSSH runs with ansible.

## Example

```ruby
runner.vm.provider "docker" do |d|
  d.name = "arillso/ansible.sshd"
  d.git_repo = "https://github.com/arillso/vagrant.container"
  d.remains_running = true
  d.has_ssh = true
end
```

## License

<!-- markdownlint-disable -->

This project is under the MIT License. See the [LICENSE](licence) file for the full license text.

<!-- markdownlint-enable -->

## Copyright

(c) 2020, Arillso
