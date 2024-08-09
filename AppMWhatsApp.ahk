; Ruta del archivo de texto que contiene el mensaje
CantidadMensajes := "C:\Users\Lizzy\OneDrive\Escritorio\enviosmasivos\CantidadMensajes.txt"  ; Reemplaza con la ruta a tu archivo

Cantidad :=FileRead(CantidadMensajes, "UTF-8")


contador := Cantidad

; Ruta del archivo de texto que contiene el mensaje
archivoMensaje := "C:\Users\Lizzy\OneDrive\Escritorio\enviosmasivos\MensajeDeWhatsApp.txt"  ; Reemplaza con la ruta a tu archivo

; Verificar si el archivo existe
if !FileExist(archivoMensaje) {
    MsgBox("El archivo no existe en la ruta especificada.")
    ExitApp()
}


; Leer el contenido del archivo y asignarlo a la variable mensaje_texto
mensaje_texto :=FileRead(archivoMensaje, "UTF-8")



; Verificar si el archivo se leyó correctamente
if (mensaje_texto = "") {
    MsgBox("El archivo está vacío o no se pudo leer.")
    ExitApp()
}

; Lista de números de WhatsApp (deben incluir el código de país, ej: +123456789)
;numeros := [ "+51977375107" ]  ; Agrega más números aquí


; Ruta del archivo de texto que contiene los números
archivoNumeros := "C:\Users\Lizzy\OneDrive\Escritorio\enviosmasivos\NumerosAEnviar.txt"  ; Reemplaza con la ruta a tu archivo

; Verificar si el archivo existe
if !FileExist(archivoNumeros) {
    MsgBox("El archivo no existe en la ruta especificada.")
    ExitApp()
}

; Leer el contenido del archivo
numerosTexto := FileRead(archivoNumeros, "UTF-8")

; Verificar si el archivo se leyó correctamente
if (numerosTexto = "") {
    MsgBox("El archivo está vacío o no se pudo leer.")
    ExitApp()
}

; Crear una lista de números desde el contenido del archivo
numeros := []
for cadaLinea in StrSplit(numerosTexto, "`n")
{
    ; Elimina espacios en blanco y saltos de línea
    numero := Trim(cadaLinea)
    if (numero != "")  ; Solo agrega números no vacíos
        numeros.Push(numero)
}




; Espera que la aplicación de escritorio de WhatsApp esté abierta y lista
MsgBox("Por favor, abre la aplicación de escritorio de WhatsApp y presiona OK para continuar.")
Sleep(2000)  ; Ajusta el tiempo si es necesario

; Itera sobre cada número en la lista y envía el mensaje
for numero in numeros
{


    ; Verifica si el contador llegó a cero
    if (contador <= 0)
    {
        MsgBox("Se Terminaron de enviar los mensajes de WhatsApp")
        ExitApp()
    }



    ; Busca el contacto
    Send("^f")
    Sleep(2000)
    Send(numero)
    Sleep(2000)

    ; Presiona Tab para seleccionar el contacto
    Send("{Tab}")
    Sleep(500)

    ; Presiona Enter para ingresar al chat del contacto
    Send("{Enter}")
    Sleep(500)

    ; Envía el mensaje de texto
    SendText(mensaje_texto)
    Send("{Enter}")
    Sleep(4000)

    ; Asegúrate de que WhatsApp Desktop esté activo
    WinActivate("WhatsApp")

    ; Pega la imagen en WhatsApp (si es necesario)
    Send("^v")
    Sleep(1000)

    ; Envía la imagen (presiona Enter para enviar)
    Send("{Enter}")
    Sleep(1000)

    Sleep(4000)

    ; Decrementa el contador
    contador--
}



MsgBox("Mensajes enviados exitosamente.")
ExitApp()


; Asigna la tecla F12 para finalizar la tarea y salir del script
F12:: {
    MsgBox("Se finalizó la tarea")
    ExitApp()
}
