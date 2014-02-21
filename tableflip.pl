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

sub own_hue {
	my ($server, $msg, $target) = @_;
	hue($server, $msg, "", $target);
}

sub public_hue {
	my ($server, $msg, $nick, $address, $target) = @_;
	hue($server, $msg, $nick.": ", $target);
}

sub own_private_hue {
	my ($server, $msg, $target, $orig_target) = @_;
	hue($server, $msg, $target, $orig_target);
}

sub private_hue {
	my ($server, $msg, $nick, $address) = @_;
	hue($server, $msg, "", $nick);
}

sub hue {
	my ($server, $msg, $nick, $target) = @_;
	return if ($msg !~ /^!flip$|^!putback$/i );
	if ($msg =~ /^!FLIP$/ ) {
		$server->command ( "msg $target ┻━┻ ︵ヽ(`Д´)ﾉ︵ ┻━┻" );
	} elsif ($msg =~ /^!flip$/i) {
		$server->command ( "msg $target (╯°□°）╯︵ ┻━┻" );
	} elsif ($msg =~ /^!putback$/i) {
		$server->command ("msg $target ┬─┬ノ(°_°ノ)");
	}
}


Irssi::signal_add_last('message public', 'public_hue');
Irssi::signal_add_last('message own_public', 'own_hue');
Irssi::signal_add_last('message private', 'private_hue');
Irssi::signal_add_last('message own_private', 'own_private_hue');

Irssi::command_bind('flip', 'table_flip');

