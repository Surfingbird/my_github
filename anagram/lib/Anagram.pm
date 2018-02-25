package Anagram;
# vim: noet:

use 5.016;
use warnings;
use strict;
use Encode;

=encoding UTF8

=head1 SYNOPSIS

Поиск анаграмм

=head1 anagram($arrayref)

Функция поиска всех множеств анаграмм по словарю.

Входные данные для функции: ссылка на массив - каждый элемент которого - слово на русском языке в кодировке utf8

Выходные данные: Ссылка на хеш множеств анаграмм.

Ключ - первое встретившееся в словаре слово из множества
Значение - ссылка на массив, каждый элемент которого слово из множества, в том порядке в котором оно встретилось в словаре в первый раз.

Множества из одного элемента не должны попасть в результат.

Все слова должны быть приведены к нижнему регистру.
В результирующем множестве каждое слово должно встречаться только один раз.
Например

anagram(['пятак', 'ЛиСток', 'пятка', 'стул', 'ПяТаК', 'слиток', 'тяпка', 'столик', 'слиток'])

должен вернуть ссылку на хеш


{
	'пятак'  => ['пятак', 'пятка', 'тяпка'],
	'листок' => ['листок', 'слиток', 'столик'],
}

=cut

sub anagram
{
	my ($ref_anagrams) = @_;
	my @words_list = @{$ref_anagrams};


	my %hash;
	my %result;
	my $arg;

	for my $i (0..$#words_list) 
	{
		chomp $words_list[$i];
		$words_list[$i] = lc decode_utf8 ($words_list[$i]);

		my @sort = split //, $words_list[$i];  
		$arg = join("", sort @sort); 

		$hash{ $words_list[$i] }  = [$arg, $i];

	}

	my @sorted_keys;

	for my $key (sort { ${$hash{$a}}[0] cmp ${$hash{$b}}[0] } keys %hash)  
	{
		push(@sorted_keys, $key);
	}

	my $ind = 1;
	my $ref = [];
	my $arg1;

	foreach $arg(@sorted_keys)
		{
			
			if ($sorted_keys[-1] eq $arg){last;}
			
			if (${$hash{$arg}}[0] eq ${$hash{ $sorted_keys[$ind] }}[0])
			{
				push(@{$ref}, $arg);
			} 

			else 
			{
				push(@{$ref}, $arg);
		
				if($ind == $#sorted_keys){
					push(@{$ref}, ${$hash{$sorted_keys[$ind]}}[0]);
				}
			
				my @index_array;

					foreach $arg1(@{$ref})
					{			
						push(@index_array,  ${$hash{$arg1}}[1]);
					}

					@index_array = sort {$a <=> $b} @index_array;

					@{$ref} = sort @{$ref};

					$result{$words_list[$index_array[0]]} = $ref;
			
				if (scalar @{$ref} == 1){delete $result{$words_list[$index_array[0]]}}
				$ref = [];
			}
			$ind++;
		}
	 return \%result;
}

1;
