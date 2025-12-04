import os
from flask import Flask, request, render_template

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def hello():
    if request.method == "POST":
        name = request.form.get("name")
        #TODO: update DB that this is the number X you visited
        return render_template("greet.html", name=name)
    return render_template("name.html")

@app.route("/health")
def health():
    return "OK", 200

@app.route("/ready")
def ready():
    return "READY", 200

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
