pragma circom 2.0.3;

include "circomlib/mimcsponge.circom";

template Reveal() {
    signal input pk;
    signal input msgAttestation;
    signal input msg;
    signal input secret;

    signal output out;

    component sign = MiMCSponge(2, 220, 1);
    sign.ins[0] <== secret;
    sign.ins[1] <== msg;
    sign.k <== 0;

    msgAttestation === sign.outs[0];

    component pubKeyGen = MiMCSponge(1, 220, 1);
    pubKeyGen.ins[0] <== secret;
    pubKeyGen.k <== 0;

    pk === pubKeyGen.outs[0];

    out <== msgAttestation;
}

component main { public [ pk, msgAttestation, msg ] } = Reveal();

/* INPUT = {
    "pk": "19865582254983874471526890191969795061851515787996165642198176014020136069169",
    "msgAttestation": "19126534410670522391594120040674375249639681087779480024337476979674173368818",
    "msg": "23424",
    "secret": "23"
} */
