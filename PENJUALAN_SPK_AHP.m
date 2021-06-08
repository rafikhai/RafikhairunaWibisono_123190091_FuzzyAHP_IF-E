namaPenjualan = {'Penjualan1' 'Penjualan2' 'Penjualan3' 'Penjualan4'};
data = [ 400 450 900
         200 225 450
         250 300 600
         100 150 300 ];

maksJumlahPelanggan = 400;
maksJumlahBarangTerjual = 500;
maksPendapatan = 1000;

data(:,1) = data(:,1) / maksJumlahPelanggan;
data(:,2) = data(:,2) / maksJumlahBarangTerjual;
data(:,3) = data(:,3) / maksPendapatan;

relasiAntarKriteria = [ 1     2     2
                        0     1     4
                        0     0     1];
                    
[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria);
                    
TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};
   
if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);
    ahp = data * bobotAntarKriteria';
    
    disp('Hasil Perhitungan dengan metode Fuzzy AHP')
    disp('PENJUALAN | Skor Akhir | Kesimpulan')
end

for i = 1:size(ahp, 1)
        if ahp(i) < 0.6
            status = 'Beri potongan harga';
        elseif ahp(i) < 0.7
            status = 'Tingkatkan promosi';
        elseif ahp(i) < 0.8
            status = 'Perkuat Brand';
        else
            status = 'Perluas target pasar';
        end
        
        disp([char(namaPenjualan(i)), blanks(13 - cellfun('length',namaPenjualan(i))), ', ', ... 
             num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), ', ', ...
             char(status)])
end