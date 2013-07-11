require "tempfile"

require "vagrant/util/template_renderer"

module VagrantPlugins
<<<<<<< HEAD
  module GuestDarwin
=======
  module GuestFreeDarwin
>>>>>>> Highly limited osx (darwin) guest plugin.
    module Cap
      class ConfigureNetworks
        include Vagrant::Util

        def self.configure_networks(machine, networks)
          # Slightly different than other plugins, using the template to build commands 
          # rather than templating the files.

<<<<<<< HEAD
          machine.communicate.sudo("networksetup -detectnewhardware")
          machine.communicate.sudo("networksetup -listnetworkserviceorder > /tmp/vagrant.interfaces")
          tmpints = File.join(Dir.tmpdir, File.basename("#{machine.id}.interfaces"))
          machine.communicate.download("/tmp/vagrant.interfaces",tmpints)

          devlist = []
          ints = IO.read(tmpints)
          ints.split(/\n\n/m).each do |i|
            if i.match(/Hardware/) and not i.match(/Ethernet/).nil?
              devmap = {}
              # Ethernet, should be 2 lines, 
              # (3) Thunderbolt Ethernet
              # (Hardware Port: Thunderbolt Ethernet, Device: en1)

              # multiline, should match "Thunderbolt Ethernet", "en1"
              devicearry = i.match(/\([0-9]+\) (.+)\n.*Device: (.+)\)/m)
              devmap[:interface] = devicearry[2]
              devmap[:service] = devicearry[1]
              devlist << devmap
            end
          end
          File.delete(tmpints)

          networks.each do |network|
            service_name = devlist[network[:interface]][:service]
            if network[:type].to_sym == :static
              command = "networksetup -setmanual \"#{service_name}\" #{network[:ip]} #{network[:netmask]}"
            elsif network[:type].to_sym == :dhcp
              command = "networksetup -setdhcp \"#{service_name}\""
            end

            machine.communicate.sudo(command)
=======
          devmap = {}
          machine.communicate.sudo("networksetup -listnetworkserviceorder > /tmp/vagrant.interfaces")
          tmpints = File.join(Dir.tmpdir, "#{machine.id}.interfaces")
          machine.communicate.download("/tmp/vagrant.interfaces",tmpints)
          ints = IO.read(tmpints)
          ints.split(/\n\n/m).each do |i|
              if i.match(/Hardware/) and not i.match(/Ethernet/).nil?
                  # Ethernet, should be 2 lines, 
                  # (3) Thunderbolt Ethernet
                  # (Hardware Port: Thunderbolt Ethernet, Device: en1)
                  devicearry = i.match(/Hardware Port: (.+), Device: en(.+)\)/)
                  devmap[devicearry[2]] = devicearry[1]
                  puts devmap
              end
          end
          networks.each do |network|

              if network[:type].to_sym == :static
                  # network seems 1 indexed - skip NAT interface (en0)
                  intnum = network[:interface]
                  puts "Network - #{intnum}"
              command = "networksetup -setmanual \"#{devmap[intnum.to_s]}\" #{network[:ip]} #{network[:netmask]} #{network[:gateway]}"

              elsif network[:type].to_sym == :dhcp
                command = "networksetup -setdhcp \"#{devmap[options[:interface]]}\""

              end

            machine.communicate.sudo("#{command}")
>>>>>>> Highly limited osx (darwin) guest plugin.
          end
        end
      end
    end
  end
end
