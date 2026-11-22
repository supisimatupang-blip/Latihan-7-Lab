program HasilStudiMahasiswa;
uses crt;

const
    MaxMhs = 50;
    MaxMk  = 20;

type
    TMatkul = record
    nama  : string;
    sks   : integer;
    nilai : string;   { A, B+, B, C+, C, D, E }
    skor  : real;     { bobot nilai x SKS }
    end;

    TMhs = record
    nama : string;
    nim  : string;
    jml  : integer;                    { jumlah mata kuliah }
    mk   : array[1..MaxMk] of TMatkul;
    end;

var
    data : array[1..MaxMhs] of TMhs;
    n, i : integer;

function NilaiKeBobot(nilai: string): real;
begin
    if      nilai = 'A'  then NilaiKeBobot := 4
    else if nilai = 'B+' then NilaiKeBobot := 3.5
    else if nilai = 'B'  then NilaiKeBobot := 3
    else if nilai = 'C+' then NilaiKeBobot := 2.5
    else if nilai = 'C'  then NilaiKeBobot := 2
    else if nilai = 'D'  then NilaiKeBobot := 1
    else if nilai = 'E'  then NilaiKeBobot := 0
    else NilaiKeBobot := -1;
end;

function HurufBesar(s: string): string;
var
    k: integer;
begin
    for k := 1 to Length(s) do
    s[k] := UpCase(s[k]);
    HurufBesar := s;
end;

function Pad(s: string; lebar: integer): string;
begin
    while Length(s) < lebar do
    s := s + ' ';
    Pad := s;
end;


procedure Garis;
begin
    WriteLn('------------------------------------------------------------');
end;

procedure InputMatkul(var m: TMatkul; no: integer);
var
    bobot: real;
begin
    WriteLn('  Mata kuliah ke-', no);
    Write('    Nama mata kuliah : ');
    ReadLn(m.nama);

    repeat
    Write('    Jumlah SKS       : ');
    ReadLn(m.sks);
    if m.sks <= 0 then
        WriteLn('    SKS harus lebih dari 0!');
    until m.sks > 0;

    repeat
    Write('    Nilai (A/B+/B/C+/C/D/E) : ');
    ReadLn(m.nilai);
    m.nilai := HurufBesar(m.nilai);
    bobot := NilaiKeBobot(m.nilai);
    if bobot < 0 then
        WriteLn('    Nilai tidak valid!');
    until bobot >= 0;

  m.skor := bobot * m.sks;
end;

procedure InputMahasiswa(var m: TMhs; no: integer);
var
    j: integer;
begin
    WriteLn;
    WriteLn('=== Data Mahasiswa ke-', no, ' ===');
    Write('Nama                  : ');
    ReadLn(m.nama);
    Write('NIM                   : ');
    ReadLn(m.nim);

    repeat
    Write('Jumlah mata kuliah    : ');
    ReadLn(m.jml);
    if (m.jml < 1) or (m.jml > MaxMk) then
        WriteLn('Jumlah harus 1 sampai ', MaxMk, '!');
    until (m.jml >= 1) and (m.jml <= MaxMk);

    WriteLn;
    for j := 1 to m.jml do
    InputMatkul(m.mk[j], j);
end;

procedure TampilMahasiswa(m: TMhs);
var
    j, totalSks : integer;
    totalSkor, ip : real;
begin
    totalSks  := 0;
    totalSkor := 0;

    WriteLn;
    WriteLn;
    WriteLn('Nama : ', m.nama);
    WriteLn('NIM  : ', m.nim);
    Garis;
    WriteLn('| No | ', Pad('Mata Kuliah', 20), ' | SKS | Nilai | Skor  |');
    Garis;

    for j := 1 to m.jml do
    begin
    WriteLn('| ', j:2, ' | ', Pad(m.mk[j].nama, 20), ' | ',
            m.mk[j].sks:3, ' | ', Pad(m.mk[j].nilai, 5), ' | ',
            m.mk[j].skor:5:1, ' |');
    totalSks  := totalSks + m.mk[j].sks;
    totalSkor := totalSkor + m.mk[j].skor;
    end;

    Garis;
    WriteLn('| TOTAL', '':41, '| ', totalSkor:5:1, ' |');
    Garis;

    if totalSks > 0 then
    ip := totalSkor / totalSks
    else
    ip := 0;

    WriteLn('Jumlah SKS : ', totalSks);
    WriteLn('IP         : ', ip:0:2);
    WriteLn;
end;

begin
    repeat
    Write('Jumlah mahasiswa yang akan diinput (1-', MaxMhs, ') : ');
    ReadLn(n);
    if (n < 1) or (n > MaxMhs) then
        WriteLn('Jumlah tidak valid!');
    until (n >= 1) and (n <= MaxMhs);

    for i := 1 to n do
    InputMahasiswa(data[i], i);

    for i := 1 to n do
    begin
    TampilMahasiswa(data[i]);
    if i < n then
    begin
        Write('Tekan Enter untuk melihat data selanjutnya..');
        ReadLn;
    end
    else
    begin
    Write('Semua data selesai ditampilkan. Tekan Enter untuk keluar..');
        ReadLn;
    end;
    end;
end.