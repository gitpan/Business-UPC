# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..28\n"; }
END {print "not ok 1\n" unless $loaded;}
use Business::UPC;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

# an object to test with:
my $upc;

# some tests with a complete, correct UPC
$upc = new Business::UPC('012345678905');

print "not " unless $upc->is_valid;
print "ok 2\n";
print "not " unless ($upc->number_system eq '0');
print "ok 3\n";
print "not " unless ($upc->mfr_id eq '12345');
print "ok 4\n";
print "not " unless ($upc->prod_id eq '67890');
print "ok 5\n";
print "not " unless ($upc->check_digit eq '5');
print "ok 6\n";

# some tests with a complete, incorrect upc
$upc = new Business::UPC('012345678900');

print "not " if $upc->is_valid;
print "ok 7\n";
print "not " unless ($upc->check_digit eq '0');
print "ok 8\n";
$upc->fix_check_digit;
print "not " unless $upc->is_valid;
print "ok 9\n";
print "not " unless ($upc->check_digit eq '5');
print "ok 10\n";

# some tests with an incomplete upc (left off leading zero)
$upc = new Business::UPC('12345678905');

print "not " unless $upc->is_valid;
print "ok 11\n";
print "not " unless ($upc->number_system eq '0');
print "ok 12\n";
print "not " unless ($upc->mfr_id eq '12345');
print "ok 13\n";
print "not " unless ($upc->prod_id eq '67890');
print "ok 14\n";
print "not " unless ($upc->check_digit eq '5');
print "ok 15\n";

# some tests with a complete type-e upc

$upc = type_e Business::UPC('01201303');

print "not " unless $upc->is_valid;
print "ok 16\n";
print "not " unless ($upc->as_upc eq '012000000133');
print "ok 17\n";

# some tests with an incomplete type-e upc

$upc = type_e Business::UPC('1201303');

print "not " unless $upc->is_valid;
print "ok 18\n";
print "not " unless ($upc->as_upc eq '012000000133');
print "ok 19\n";

# tests for constructing with unknown check digit

$upc = new Business::UPC('01200000013x');

print "not " unless (uc($upc->check_digit) eq 'X');
print "ok 20\n";
$upc->fix_check_digit;
print "not " unless ($upc->check_digit eq '3');
print "ok 21\n";

# test for coupon stuff

print "not " if ($upc->is_coupon);
print "ok 22\n";

$upc = new Business::UPC('512345678900');

print "not " unless ($upc->is_valid);
print "ok 23\n";
print "not " unless ($upc->is_coupon);
print "ok 24\n";
print "not " unless ($upc->number_system_description eq 'Coupon');
print "ok 25\n";
print "not " unless ($upc->coupon_value eq '$0.90');
print "ok 26\n";
print "not " unless ($upc->coupon_family_code eq '678');
print "ok 27\n";
print "not " unless ($upc->coupon_family_description eq 'Unknown');
print "ok 28\n";



