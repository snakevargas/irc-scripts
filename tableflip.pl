use Irssi;

use vars qw($VERSION %IRSSI);

$VERSION = "0.1";
%IRSSI = (
	author => 'SnakeVargas',
	name => 'TableFlip',
	description => 'Flips tables',
	license => 'Super proprietary, you should pay SnakeVargas many dogecoins for this script'
);


sub table_flip {
	my ($data, $server, $witem) = @_;
	if (!$server || !$server->{connected}) {
		Irssi::print("Not connected to server");
		return;
	}
	if ($data) {
		$server->command("msg $data (╯°□°）╯︵ ┻━┻");
	} elsif ($witem && ($witem->{type} eq "CHANNEL" || $witem->{type} eq "QUERY")) {
		# There's query/channel active in window
		$witem->command("msg " . $witem->{name} . " (╯°□°）╯︵ ┻━┻");
	} else {
		Irssi::print("Nick not given, and no active channel/query in window");
		return
	}
}

Irssi::command_bind('flip', 'table_flip');

