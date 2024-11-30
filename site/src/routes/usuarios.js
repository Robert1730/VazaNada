var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
    console.log('estou na rota de cadastro')
})

router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

router.get("/verificarEmail", function (req, res) {
    usuarioController.verificarEmail(req, res);
});

router.get("/criticoKPI", function (req, res) {
    usuarioController.criticoKPI(req, res);
});

router.get("/seguroKPI", function (req, res) {
    usuarioController.seguroKPI(req, res);
});

router.get("/alertaKPI", function (req, res) {
    usuarioController.alertaKPI(req, res);
});




module.exports = router;