#!/bin/zsh

setopt err_exit no_unset

mkdir -p svg pdf png

# S. 6, 11ff
ice1_offset=11
# Stelle 6 bis 9 der UIC-Wagennr.
typeset -a ice1_types=(
8018 # Avmz, "93805>8018<566"
8014 # Avmz, "93805>8010<068"
8010 # Avmz, "93805>8010<571"
8031 # Apmbsz, "93805>8031<569"
8040 # WRmz ("WSmz")
8020 # Bvmz
8029 # Bpmz
8023 # Bvmz handy, familie
8023 # Bvmz ruhe
8023 # Bvmz handy
8026 # Bvmz
8028 # Bvmz
8027 # Bvmz
)

# S. 25, 28ff
# Stelle 6 bis 9
ice2_bbox='77 46 825 175'
ice2_offset=28
typeset -a ice2_types=(
8053 # Apmz
8050 # Apmz
8070 # WRmbsz
8060 # Bpmbz
8063 # Bpmz
8066 # Bpmz
8080 # Bpmzf
)

# S. 36, 39ff
# Stelle 6 bis 9
ice3_403_1_bbox='77 38 825 197'
ice3_403_1_offset=39
typeset -a ice3_403_1_types=(
31_4030 # Apmzf
31_4031 # Avmz
31_4032 # Bvmz
31_4033 # BRmz
31_4038 # Bpmbz
31_4037 # Bpmz
31_4036 # Bpmz
31_4035 # Bpmzf
)

# S. 47, 50ff
# Stelle 6 bis 9
ice3_403_2_bbox='77 38 825 197'
ice3_403_2_offset=50
typeset -a ice3_403_2_types=(
32_4030 # Apmzf
32_4031 # Avmz
32_4032 # Bvmz
32_4033 # BRmz
32_4038 # Bpmbz
32_4037 # Bpmz
32_4036 # Bpmz
32_4035 # Bpmzf
)

# S. 58, 61ff
# Stelle 6 bis 9
ice3_403_r_bbox='77 38 825 147'
ice3_403_r_offset=61
typeset -a ice3_403_r_types=(
3r_4030 # Apmzf
3r_4031 # Avmz
3r_4032 # Bvmz
3r_4033 # WRmz
3r_4038 # Bpmbz
3r_4037 # Bpmz
3r_4036 # Bpmz
3r_4035 # Bpmzf
)

# Mehrsystem
# S. 69, 72ff
# Stelle 6 bis 9
ice3_406_bbox='77 38 825 197'
ice3_406_offset=72
typeset -a ice3_406_types=(
3_4060 # Apmzf
3_4061 # Avmz
3_4062 # Bvmz
3_4063 # BRmz
3_4068 # Bpmbz
3_4067 # Bpmz
3_4066 # Bpmz
3_4065 # Bpmzf
)

# S. 80, 83ff
# Mehrsystem
# Stelle 6 bis 9
ice3_406_r_bbox='77 38 825 147'
ice3_406_r_offset=83
typeset -a ice3_406_r_types=(
3r_4060 # Apmzf
3r_4061 # Avmz
3r_4062 # Bvmz
3r_4063 # WRmz
3r_4068 # Bpmbz
3r_4067 # Bpmz
3r_4066 # Bpmz
3r_4065 # Bpmzf
)

# S. 91, 94ff
# Velaro
# Stelle 6 bis 9
ice3_407_bbox='77 38 825 197'
ice3_407_offset=94
typeset -a ice3_407_types=(
4070 # Apmzf
4071 # Apmz
4072 # ARmz
4073 # Bpmbsz
4078 # Bpmz
4077 # Bpmz
4076 # Bpmz
4075 # Bpmzf
)

# S. 103, 107ff
# Stelle 5 bis 9
ice4_bbox='77 45 825 180'
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
icet_411_s1_bbox='77 38 825 160'
icet_411_s1_offset=123
typeset -a icet_411_s1_types=(
t1_4110 # Apmzf
t1_4111 # ABpmz
t1_4112 # WRmz
t1_4118 # Bpmdz
t1_4117 # Bpmbz
t1_4116 # Bpmz
t1_4115 # Bpmzf
)

# S. 130, 133ff
# Stelle 6 bis 9
icet_411_s2_bbox='77 38 825 160'
icet_411_s2_offset=133
typeset -a icet_411_s2_types=(
t2_4110 # Apmzf
t2_4111 # ABpmz
t2_4112 # WRmz
t2_4118 # Bpmdz
t2_4117 # Bpmz
t2_4116 # Bpmbz
t2_4115 # Bpmzf
)

# S. 140, 143ff
# Stelle 6 bis 9
icet_415_bbox='77 38 825 197'
icet_415_offset=143
typeset -a icet_415_types=(
4150 # Apmzf
4151 # BRpmz
4157 # Bpmz
4156 # Bpmbz
4155 # Bpmzf
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
ic1_bbox='78 50 818 140'
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
ic2_bt_bbox='78 110 804 390'
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
ic2_sk_bbox='78 110 820 390'
ic2_sk_offset=196
typeset -a ic2_sk_types=(
1106 # DABpzfa # 110.F
x
1105 # DBpza # 110.E
x
1104 # DBpbza # 110.D
x
1101 # DBpdzfa # 110.A
)

function extract_wagons {
	start=$1
	shift
	bbox=$1
	shift

	for i in {1..$#}; do
		target=$@[$i]

		if [[ $target == x ]]; then
			continue
		fi

		echo "Page $(( start + i - 1 )): $target"

		pdfcrop --bbox $bbox tmp-$(( start + i - 1 )).pdf crop.pdf &> /dev/null

		# The wagon layout uses two white rectangles as background. one spans the
		# entire page, one just the wagon. By removing these, we gain a wagon
		# image with a transparent background, allowing it to be used both on
		# light and dark HTML pages. The background's path IDs are (somewhat)
		# random, so we simply remove all paths whose width exceeds the expected
		# width of the wagon symbol.
		paths=$(
			IFS=,
			typeset -a objects
			inkscape --query-all crop.pdf 2> /dev/null | while read o x y w h; do
				if (( w > 1000 )) && [[ $o == path* ]]; then
					objects+=$o
				elif (( x < 0 || y < 0 )) && [[ $o == path* || $o == tspan* ]]; then
					objects+=$o
				fi
			done
			echo ${(j:,:)objects}
		)

		# when an inkscape command uses GUI verbs and performs a PDF import, it
		# opens the PDF Import Settings dialog. This cannot be overridden.
		# So we first convert to SVG (without GUI verbs, thus without triggering
		# the dialog) and then to PNG.
		inkscape --export-filename=svg/${target}.svg crop.pdf &> /dev/null
		xvfb-run inkscape --select=${paths} --verb=EditDelete --batch-process \
			--export-dpi=600 -o png/${target}.png svg/${target}.svg &> /dev/null

		mv crop.pdf pdf/${target}.pdf
	done
}

function extract_wagons_heuristic {
	start=$1
	shift

	for i in {1..$#}; do
		target=$@[$i]

		if [[ $target == x ]]; then
			continue
		fi

		echo "Page $(( start + i - 1 )): $target"
		inkscape --export-filename=svg/${target}.svg tmp-$(( start + i - 1 )).pdf &> /dev/null
		lib/export-carriage.py svg/${target}.svg png/${target}.png
	done
}

pdfseparate Fahrzeuglexikon_2020.pdf tmp-%d.pdf

extract_wagons_heuristic $ice1_offset        $ice1_types
extract_wagons_heuristic $ice2_offset        $ice2_types
extract_wagons_heuristic $ice3_403_1_offset  $ice3_403_1_types
extract_wagons_heuristic $ice3_403_2_offset  $ice3_403_2_types
extract_wagons_heuristic $ice3_403_r_offset  $ice3_403_r_types
extract_wagons_heuristic $ice3_406_offset    $ice3_406_types
extract_wagons_heuristic $ice3_406_r_offset  $ice3_406_r_types
extract_wagons_heuristic $ice3_407_offset    $ice3_407_types
extract_wagons_heuristic $ice4_offset        $ice4_types
extract_wagons_heuristic $icet_411_s1_offset $icet_411_s1_types
extract_wagons_heuristic $icet_411_s2_offset $icet_411_s2_types
extract_wagons_heuristic $icet_415_offset    $icet_415_types
extract_wagons_heuristic $ic1_offset         $ic1_types
extract_wagons $ic2_bt_offset $ic2_bt_bbox $ic2_bt_types
extract_wagons $ic2_sk_offset $ic2_sk_bbox $ic2_sk_types

rm tmp-*

perl -MJSON -E 'say JSON->new->canonical->encode({map {$_ => true} @ARGV})' \
	png/*(:t:r) > png/wagons.json

chmod -R a+rX png
rsync -a --info=progress2 --delete png/ epicentre:web/org.finalrewind.lib/out/dbdb/db_wagen/
