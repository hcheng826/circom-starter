pragma circom 2.0.3;

include "circomlib/mimcsponge.circom";

template GroupSig() {
    signal input sk;
    signal input pk1;
    signal input pk2;
    signal input pk3;
    signal input msgHash;  // (a) why is this needed?

    // (b) pk generation
    component pkGen = MiMCSponge(1, 220, 1);
    pkGen.ins[0] <== sk;
    pkGen.k <== 0;

    signal pk;
    pk <== pkGen.outs[0];

    // (c) constraints checking pk
    signal interm;
    interm <== (pk - pk1) * (pk - pk2);
    interm * (pk - pk3) === 0;

    // fun fact!
    signal dummy;
    dummy <== msgHash * msgHash;
}



component main { public [ pk1, pk2, pk3, msgHash ] } = GroupSig();
// component main { public [ ins, k ] } = MiMCSponge(1, 220, 1);
//  /* I NPUT = { // break the regex for input
//     "ins": ["23"],
//     "k": "0"
// } */

/* INPUT = {
    "sk": "23",
    "pk1": "19865582254983874471526890191969795061851515787996165642198176014020136069169",
    "pk2": "112",
    "pk3": "123",
    "msgHash": "23424"
} */
