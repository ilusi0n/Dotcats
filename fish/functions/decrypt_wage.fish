function decrypt_wage
    mkdir -p old

    for f in *.pdf
        set filename (string replace -r '\.pdf$' '' -- $f)
        set out "$filename"2.pdf

        echo $filename

        qpdf --password=218271395 --decrypt "$filename.pdf" "$out"

        mv "$filename.pdf" old/
        mv "$out" "$filename.pdf"
    end
end