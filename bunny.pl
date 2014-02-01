use Irssi;

use vars qw($VERSION %IRSSI);

$VERSION = "0.3";
%IRSSI = (
	author => 'SnakeVargas',
	name => 'Bunnybot',
	description => 'Bunnies on demand',
	license => 'Super proprietary, you should pay SnakeVargas many dogecoins for this script'
);

sub own_bunny {
	my ($server, $msg, $target) = @_;
	bunny($server, $msg, "", $target);
}

sub public_bunny {
	my ($server, $msg, $nick, $address, $target) = @_;
	bunny($server, $msg, $nick.": ", $target);
}

sub own_private_bunny {
	my ($server, $msg, $target, $orig_target) = @_;
	bunny($server, $msg, $target, $orig_target);
}

sub private_bunny {
	my ($server, $msg, $nick, $address) = @_;
	bunny($server, $msg, "", $nick);
}

sub bunny {
	my ($server, $msg, $nick, $target) = @_;
	return if ($msg !~ /^!bunny$/i );
	$server->command ( "msg $target  (())(())" );
	$server->command ( "msg $target  ( >'.'<)" );
	$server->command ( "msg $target c(\" )( \")" );
}


Irssi::signal_add_last('message public', 'public_bunny');
Irssi::signal_add_last('message own_public', 'own_bunny');
Irssi::signal_add_last('message private', 'private_bunny');
Irssi::signal_add_last('message own_private', 'own_private_bunny');

