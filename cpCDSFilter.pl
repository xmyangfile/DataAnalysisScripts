use Bio::SeqIO;

# Set the input file path
my $input_file = $ARGV[0];

# Check if the input file exists
open my $fh, $input_file or die "Cannot open file: $input_file";

# Create a sequence input object
my $seq_io = Bio::SeqIO->new(-file => $input_file, -format => 'fasta');

while (my $seq_obj = $seq_io->next_seq()) {
    my $id = $seq_obj->id;
    my $sequence = $seq_obj->seq;
    my $description = $seq_obj->desc;
    my @description_parts = split("=|]", $description);
    my $length = length($sequence);
    my $start_codon = substr($sequence, 0, 3);
    my $end_codon = substr($sequence, -3);
    if ($start_codon eq "ATG" && $length > 300 && 
        ($end_codon eq "TAA" || $end_codon eq "TAG" || $end_codon eq "TGA")) {
        print ">$description_parts[1]\t$length\n$sequence\n";
    }
}
