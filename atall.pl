use Irssi;

use vars qw($VERSION %IRSSI);

$VERSION = "0.1";
%IRSSI = (
	author => 'SnakeVargas',
	name => '@all',
	description => 'Mentions everyone in the room',
	license => 'Super proprietary, you should pay SnakeVargas many dogecoins for this script'
);

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
	return if ($msg !~ /\@all/i );
	my $channel = Irssi::active_win->{active};
	my @nicks = $channel->nicks();
	my @nicknames;
	foreach(@nicks) {
		push @nicknames, $_->{nick};
	}
	$theNicks = join(' ', @nicknames);
	$server->command ( "msg $target $theNicks" );
}


Irssi::signal_add_last('message public', 'public_hue');
Irssi::signal_add_last('message own_public', 'own_hue');
#Irssi::signal_add_last('message private', 'private_hue');
#Irssi::signal_add_last('message own_private', 'own_private_hue');

