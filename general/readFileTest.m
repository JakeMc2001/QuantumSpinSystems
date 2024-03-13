function Bonds=readFileTest()
    fileID = fopen("24HoneyIR/Honey24_bonds1.dat");
    Bonds = textscan(fileID,'K1%s %d %d');
    fclose(fileID);
end