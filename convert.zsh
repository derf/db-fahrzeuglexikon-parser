#!/bin/zsh

setopt err_exit no_unset

mkdir -p svg pdf png

# S. 6, 11ff
ice1_offset=11
# Stelle 6 bis 9 der UIC-Wagennr.
typeset -a ice1_types=(
58018 # Avmz, "93805>8018<566"
58014 # Avmz, "93805>8010<068"
58010 # Avmz, "93805>8010<571"
58031 # Apmbsz, "93805>8031<569"
58040 # WRmz ("WSmz")
58020 # Bvmz
58029 # Bpmz
58023 # Bvmz handy, familie
58023 # Bvmz ruhe
58023 # Bvmz handy
58026 # Bvmz
58028 # Bvmz
58027 # Bvmz
)

# S. 25, 28ff
# Stelle 6 bis 9
ice2_offset=28
typeset -a ice2_types=(
58053 # Apmz
58050 # Apmz
58070 # WRmbsz
58060 # Bpmbz
58063 # Bpmz
58066 # Bpmz
58080 # Bpmzf
)

# S. 36, 39ff
# Stelle 6 bis 9
ice3_403_1_offset=39
typeset -a ice3_403_1_types=(
54030.1 # Apmzf
54031.1 # Avmz
54032.1 # Bvmz
54033.1 # BRmz
54038.1 # Bpmbz
54037.1 # Bpmz
54036.1 # Bpmz
54035.1 # Bpmzf
)

# S. 47, 50ff
# Stelle 6 bis 9
ice3_403_2_offset=50
typeset -a ice3_403_2_types=(
54030.2 # Apmzf
54031.2 # Avmz
54032.2 # Bvmz
54033.2 # BRmz
54038.2 # Bpmbz
54037.2 # Bpmz
54036.2 # Bpmz
54035.2 # Bpmzf
)

# S. 58, 61ff
# Stelle 6 bis 9
ice3_403_r_offset=61
typeset -a ice3_403_r_types=(
54030.r # Apmzf
54031.r # Avmz
54032.r # Bvmz
54033.r # WRmz
54038.r # Bpmbz
54037.r # Bpmz
54036.r # Bpmz
54035.r # Bpmzf
)

# Mehrsystem
# S. 69, 72ff
# Stelle 6 bis 9
ice3_406_offset=72
typeset -a ice3_406_types=(
54060 # Apmzf
54061 # Avmz
54062 # Bvmz
54063 # BRmz
54068 # Bpmbz
54067 # Bpmz
54066 # Bpmz
54065 # Bpmzf
)

# S. 80, 83ff
# Mehrsystem
# Stelle 6 bis 9
ice3_406_r_offset=83
typeset -a ice3_406_r_types=(
54060.r # Apmzf
54061.r # Avmz
54062.r # Bvmz
54063.r # WRmz
54068.r # Bpmbz
54067.r # Bpmz
54066.r # Bpmz
54065.r # Bpmzf
)

# S. 91, 94ff
# Velaro
# Stelle 6 bis 9
ice3_407_offset=94
typeset -a ice3_407_types=(
54070 # Apmzf
54071 # Apmz
54072 # ARmz
54073 # Bpmbsz
54078 # Bpmz
54077 # Bpmz
54076 # Bpmz
54075 # Bpmzf
)

# S. 103, 107ff
# Stelle 5 bis 9
ice4_offset=107
typeset -a ice4_types=(
08120 # Apmzf, "938008120264"
18120 # Apmz, "938018120262"
14120 # Apmz
88120 # ARmz
64120 # Bpmbsz
98120 # Bpmz
24120 # Bpmz
24123 # Bpmz
48120 # Bpmz
24125 # Bpmz
24128 # Bpmz
58120 # Bpmdzf
)

# S. 120, 123ff
# Stelle 6 bis 9
icet_411_s1_offset=123
typeset -a icet_411_s1_types=(
54110.1 # Apmzf
54111.1 # ABpmz
54112.1 # WRmz
54118.1 # Bpmdz
54117.1 # Bpmbz
54116.1 # Bpmz
54115.1 # Bpmzf
)

# S. 130, 133ff
# Stelle 6 bis 9
icet_411_s2_offset=133
typeset -a icet_411_s2_types=(
54110.2 # Apmzf
54111.2 # ABpmz
54112.2 # WRmz
54118.2 # Bpmdz
54117.2 # Bpmz
54116.2 # Bpmbz
54115.2 # Bpmzf
)

# S. 140, 143ff
# Stelle 6 bis 9
icet_415_offset=143
typeset -a icet_415_types=(
54150 # Apmzf
54151 # BRpmz
54157 # Bpmz
54156 # Bpmbz
54155 # Bpmzf
)

# S. 149, 152ff
typeset -a met_types=(
1160 # Apmz (2. Kl.)
1161 # Apmz (2. Kl.)
1166 # Apmkz (2. Kl.)
1164 # Apmz (2. Kl.)
1162 # Apmz (2. Kl.)
1166 # Apmkz (1. Kl.)
1168 # Apmbzf (1. Kl.)
)

# S. 160, 164ff
ic1_offset=164
typeset -a ic1_types=(
	Apmmz # 126
	Avmmz # 106
	ARkimmbz # 288
	Bvmmsz # 187
	Bpmmbdz # 284
	Bpmmz # 284
	Bvmmz # 188.1
	Bpmmbdzf # 286
	Apmmz # 118
	Bpmmbz # 284
	Bpmmdz # 285
	Bimmdzf # 287
	Avmz # 109
	ARkimbz # 266
	Bvmsz # 186
	Bpmbz # 294
	Bpmbz # 294
)

# S. 182, 187, 189, 191
# Bombardier Twindexx
ic2_bt_offset=187
typeset -a ic2_bt_types=(
DApza # 6872 # DApza # 687.2
x
DBpza # 6822 # DBpza # 682.2
x
DBpbzfa # 6682 # DBpbzfa # 668.2
)

# S. 192, 196, 198, 200, 202
# Stadler KISS
ic2_sk_offset=196
typeset -a ic2_sk_types=(
41106 # DABpzfa # 110.F
x
41105 # DBpza # 110.E
x
41104 # DBpbza # 110.D
x
41101 # DBpdzfa # 110.A
)

function extract_wagons {
	start=$1
	shift

	for i in {1..$#}; do
		target=$@[$i]

		if [[ $target == x ]]; then
			continue
		fi

		echo "Page $(( start + i - 1 )): $target"
		cp tmp-$(( start + i - 1 )).pdf pdf/${target}.pdf
		inkscape --export-filename=svg/${target}.svg pdf/${target}.pdf &> /dev/null
		lib/export-carriage.py svg/${target}.svg png/${target}.png png/${target}.svg
		if (( doubledecker )); then
			double_decker_export=upper lib/export-carriage.py svg/${target}.svg png/${target}_u.png png/${target}_u.svg
			double_decker_export=lower lib/export-carriage.py svg/${target}.svg png/${target}_l.png png/${target}_l.svg
			lib/carriage-json.pl png/wagons.json tmp-$(( start + i - 2 )).pdf ${target} ${target}_u ${target}_l
		else
			lib/carriage-json.pl png/wagons.json pdf/${target}.pdf ${target}
		fi
	done
}

pdfseparate Fahrzeuglexikon_2020.pdf tmp-%d.pdf

echo '{}' > png/wagons.json

doubledecker=0

extract_wagons $ice1_offset        $ice1_types
extract_wagons $ice2_offset        $ice2_types
extract_wagons $ice3_403_1_offset  $ice3_403_1_types
extract_wagons $ice3_403_2_offset  $ice3_403_2_types
extract_wagons $ice3_403_r_offset  $ice3_403_r_types
extract_wagons $ice3_406_offset    $ice3_406_types
extract_wagons $ice3_406_r_offset  $ice3_406_r_types
extract_wagons $ice3_407_offset    $ice3_407_types
extract_wagons $ice4_offset        $ice4_types
extract_wagons $icet_411_s1_offset $icet_411_s1_types
extract_wagons $icet_411_s2_offset $icet_411_s2_types
extract_wagons $icet_415_offset    $icet_415_types
extract_wagons $ic1_offset         $ic1_types

doubledecker=1

extract_wagons $ic2_bt_offset $ic2_bt_types
extract_wagons $ic2_sk_offset $ic2_sk_types

rm tmp-*

chmod -R a+rX png
rsync -a --info=progress2 --delete png/ epicentre:web/org.finalrewind.lib/out/dbdb/db_wagen/
