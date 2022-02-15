#! /bin/sh

testbench() {
	if [[ ! -e "./hw3_sample_$1" ]]; then
		if [[ ! -e "./hw3_sample_$1.c" ]]; then
			echo "./hw3_sample_$1 not found."
			exit 1
		fi
		gcc "./hw3_sample_$1".c -o "./hw3_sample_$1"
	fi

	printf "testing $1"

	for i in $(seq 0 $2); do
		if (($i % 10 == 0)); then
			printf "."
		fi
		got=$(echo $i | jupiter ./b08902001_hw3_$1.s | sed "/^$/,/Jupiter/d")
		expected=$(echo $i | ./hw3_sample_$1)
		if [[ $got -ne $expected ]]; then
			echo "expect $expected, but got $got when n = $i"
			exit
		fi
	done

	echo " done."
}

testbench fibonacci 15
testbench recaman 200