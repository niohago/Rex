#
# (c) Jan Gehring <jan.gehring@gmail.com>
# 
# vim: set ts=3 sw=3 tw=0:
# vim: set expandtab:
   
package Rex::Virtualization::Base;

use strict;
use warnings;

sub new {
   my $that = shift;
   my $proto = ref($that) || $that;
   my $self = { @_ };

   bless($self, $proto);

   return $self;
}

sub execute {
   my ($self, $action, $vmname, @opt) = @_;

   my $mod = ref($self) . "::$action";
   eval "use $mod;";

   if($@) {
      Rex::Logger::info("No action $action available.");
      die("No action $action available.");
   }

   return $mod->execute($vmname, @opt);

}

1;
