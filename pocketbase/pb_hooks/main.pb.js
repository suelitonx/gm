// pb_hooks/main.pb.js

routerAdd("get", "/susu/:username", async (c) => {
    
    const username = c.pathParam("username")

    const user = $app.dao().findAuthRecordByUsername("users", username)

    const nome = user.getString("name")
    console.log(nome)

    //return c.json(200, user)

    const html = $template.loadFiles(
        `${__hooks}/views/layout.html`,
        `${__hooks}/views/hello.html`,
    ).render({
        "name": nome,
        "email": user.getString("email"),
        "foto": user.getString("avatar"),
    })

    return c.html(200, html)
})

routerAdd("get", "/hora", async (c) => {
    const date = new Date();

    return c.html(200, date)
})

routerAdd("GET", "/validarcodigo", async (c) => {
    
    //const codygo = c.request().header.get("codigo");
    let codygo = $apis.requestInfo(c).headers["codigo"];

    //let codygo = c.pathParam("codigo");
    try {
        $app.dao().findFirstRecordByFilter(
            "alunos", "codigo = {:cod}",
            { cod: codygo },
        );

        return c.json(200, { "code": 400, "message": "Código não é válido, já existe um cadastrado."});
    } catch (err) {
        return c.json(200, { "code": 200, "message": "Código válido."});
    }
    
}, $apis.activityLogger($app), $apis.requireRecordAuth("users"))

onRecordAfterCreateRequest((e) => {

    let codigo_aluno = e.record.getString("codigo");
    if(codigo_aluno == "") {

        function existe(codygo) {
            try {
                $app.dao().findFirstRecordByFilter(
                    "alunos", "codigo = {:cod}",
                    { cod: codygo },
                );
        
                return true;
            } catch (err) {
                return false;
            }
        }

        let nome = e.record.getString("nome");

        let cod = '';

        let telefone = e.record.getString("telefone");
        
        let primeiroNome = nome.split(" ")[0];

        let ultimoNome = nome.split(' ').length > 1 ? nome.split(' ').pop() : "";

        cod += primeiroNome.toLowerCase();
        cod += ultimoNome.toLowerCase();
        
        let adicionoutel = false;

        let i = 1;
        while (existe(cod)) {

            if(adicionoutel == false) {
                cod += telefone.length > 4 ? telefone.slice(-4) : new Date().getFullYear();
                adicionoutel = true;
            }
            else
            {
                cod += (Math.floor(Math.random() * 9) + 1);
                i++;
            }
        }

        e.record.set("codigo", cod);

        $app.dao().saveRecord(e.record);

    }

}, "alunos")