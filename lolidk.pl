use Irssi;

use vars qw($VERSION %IRSSI);

$VERSION = "0.7";
%IRSSI = (
	author => 'SnakeVargas',
	name => 'Huebot',
	description => 'Hues on demand',
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
	return if ($msg !~ /^!lo+lidk$/i );
	$hue = "¯\\";
	$lolLength = length($msg) - length("!lolidk");
	$hueArms = "_";
	for(my $i = 0; $i < $lolLength; $i++) {
		$hueArms .= "_";
	}
	$hue .= $hueArms;
	$hue .= "(ツ)";
	$hue .= $hueArms;
	$hue .= "/¯";
	$server->command ( "msg $target $hue" );
}


Irssi::signal_add_last('message public', 'public_hue');
Irssi::signal_add_last('message own_public', 'own_hue');
Irssi::signal_add_last('message private', 'private_hue');
Irssi::signal_add_last('message own_private', 'own_private_hue');

