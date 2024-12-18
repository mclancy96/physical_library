class DeleteExtraneousCodes < ActiveRecord::Migration[7.1]
  def change
    delete_codes = %w[001.543 005.01 005.02 005.06 005.09 100.07 070.23 070.32 804.3 132.1 132.2 132.3 132.4 132.5 
                      132.6 132.7 132.8 220.01 220.02 220.03 220.04 220.05 220.06 220.07 220.08 220.09 611.1242 611.1245 611.1252 611.1255
                      611.1263 611.1264 611.1265 611.12646 611.12642 611.1265 611.12650 611.12652 611.1266 611.12662 611.12665 136.1
                      136.2 136.3 136.4 136.5 136.6 136.7 136.71 136.72 136.73 136.74 136.75 136.76 136.77 136.79 136.741 136.742
                      136.743 136.744 136.747 136.757 136.761 136.762 136.763 136.764 136.765 136.766 136.769 136.7612
                      611.1312 611.1315 611.1321 611.1322 611.1325 611.1331 611.13222 611.13225 151.1 151.2 308.1 308.5
                      426.1 426.2 426.3 426.4 426.5 426.6 426.7 426.8 309.1 309.2 309.26 309.262 427.2 427.3 427.4 427.5
                      427.6 427.7 427.8 427.21 427.23 427.25 427.27 427.28 427.29 427.31 427.33 427.34 427.35 427.37 427.38
                      427.41 427.43 427.44 427.45 427.46 427.47 427.48 427.51 427.52 427.53 427.54 427.55 427.56 427.57 427.58 427.59
                      427.61 427.64 427.67 427.71 427.72 427.74 427.81 427.82 427.85 427.88 427.89 157.1 157.2 157.3 157.9 157.32
                      237.1 237.2 237.3 237.4 237.5 237.6 237.7 244.1 244.3 245.2 245.3 544.1 544.2 544.3 544.4 544.5
                      544.6 544.7 544.8 544.9 544.92 181.04 181.06 181.07 181.09 181.043 181.044 181.046 181.074 181.095 181.0951
                      545.1 545.2 545.3 545.4 545.5 545.6 545.7 545.8 545.9 818.99 818.995 818.9956 818.99569 818.995691
                      818.995692 818.9956923 821.091 821.092 821.093 821.094 821.0935 821.09353 329.1 329.2 329.3 329.4
                      329.5 329.6 329.8 329.9 329.84 329.94 329.95 329.96 329.97 329.98 329.99 329.941 329.942 329.943
                      329.944 329.945 329.946 329.947 329.949 329.951 329.952 329.956 329.959 329.965 329.966 329.971
                      329.973 329.991 329.993 329.994 329.9415 329.9438 329.9495 329.9567 329.9598 329.9669 329.9712
                      329.9714 329.9914 329.9931 329.9943 329.9944 329.97124 332.404 332.409 332.4042 332.4043 332.4044
                      332.4048 332.4094 332.4097 332.4099 332.40440 332.404409 332.4044094 332.4044096 332.4044097
                      332.40440941 332.40440942 332.40440973 447.900 839.09 839.091 839.092 839.093 839.094 839.095
                      839.096 839.097 839.098 839.0911 839.0912 839.0913 839.0921 839.0922 839.0923 839.0931 839.0932
                      839.0933 839.323 839.324 839.325 839.3231 839.3232 839.3233 839.3234 839.3235 839.3236 839.3239
                      839.3241 839.3242 839.3243 839.3244 839.3245 839.3249 839.3251 839.3252 839.3253 839.334 839.335
                      839.3341 839.3342 839.3343 839.3351 839.3352 839.3353 839.3354 839.3355 839.3356 839.344 839.345
                      839.3451 839.3452 839.3453 839.3454 839.3455 839.371 839.374 839.381 839.384 654.2 654.3 654.4
                      654.5 654.6 654.7 651.11 651.12 651.13 651.14 651.16 651.19 651.241 651.242 651.243 651.2625
                      651.2628 651.2641 651.2643 651.2644 651.2645 651.2646 651.2648 651.26411 651.26412 651.26413
                      760.92 651.321 651.3735 651.382 651.384 651.385 651.3825 636.08431 968.11 968.13 968.16
                      651.41 651.5132 651.5135 651.5138 651.522 651.523 651.525 636.2971 636.2972 491.62789 491.63726
                      651.42 651.5332 651.5334 651.5335 651.5336 636.082431 636.082432 968.63 968.634
                      651.43 651.552 651.554 651.563 651.5632 651.5634 651.5636 487.81 487.85 491.63724
                      651.45 651.542 651.543 651.545 651.546 651.712 651.713 651.714 651.715 651.717 651.718
                      651.46 651.62 651.63 651.64 651.65 651.66 651.67 651.672 651.673 651.675 651.677 651.678
                      651.47 641.10 641.11 641.12 641.13 641.14 641.15 641.16 641.17 491.63721 491.63722 491.63723
                      651.412 396.1 396.2 396.4 396.5 396.6 396.7 396.8 396.9 396.58 491.857032 491.63725
                      651.431 492.4518 882.091 882.092 882.093 882.21 882.22 882.23 491.5482 491.5483
                      651.432 891.540 891.541 891.542 891.543 891.544 891.5404 891.5408 491.62795 491.62796
                      651.433 891.578 797.210 491.540 491.541 491.542 491.543 491.544 491.545 491.546 491.547 491.548
                      651.434 491.62761 491.62762 491.62763 491.62764 491.62765 491.62766 491.62767 491.62768 491.62769
                      651.435 491.62771 491.62772 491.62773 491.62774 491.62775 491.62791 491.62792 491.62793 491.62794
                      651.436 491.766 491.62781 491.62782 491.62783 491.62784 491.62785 491.62786 491.62787 491.62788
                      651.438 491.580 491.581 491.582 491.583 491.584 491.585 491.586 491.587 491.588 491.5834
                      651.451 491.63711 491.63712 491.63713 491.63714 491.63715 491.63716 491.63717
                      651.452 491.63731 491.63732 491.63733 491.63734 491.63735 491.63736 491.63737 491.63738 491.63739
                      651.453 491.63741 491.63742 491.63743 491.63744 491.63745 491.63746 491.63747 491.63748 491.63749
                      651.455 491.690 491.691 491.692 491.693 491.694 491.695 491.696 491.697 491.698  651.456 651.457
                      651.461 651.462 651.463 651.464 651.465 651.466 651.472 651.473 651.474 651.4651 651.4652
                      651.4653 651.4654 651.4655 651.4656 651.4658 651.4659 651.4662 651.4663 651.4667 651.4668
                      651.4669 636.08131 636.08171 636.08173 636.08175 636.08181 636.08187 636.08188 636.702
                      636.703 636.706 636.707 636.708 636.7081 636.7082 636.7083 636.7084 636.7085 636.7088 636.7089
                      636.70821 636.70831 636.70832 636.70833 636.70852 636.70855 636.70886 636.70887 636.70888
                      636.70891 636.70892 636.70893 636.70895 636.70896 636.70897 636.70898 636.708932 636.708937
                      636.708951 636.708959 636.708961 636.708962 636.708963 636.708964 636.708965 636.708966 636.708967
                      636.708968 636.708976 636.708977 636.708978 636.708982 636.708989 636.7089633 636.7089639
                      636.7089652 636.7089689 636.7089892 636.7089897 636.800 636.807 636.808 636.8001 636.8002
                      636.8003 636.8008 636.8009 636.8081 636.8082 636.8083 636.8084 636.8085 636.8088 636.8089
                      636.80092 636.80094 636.80095 636.80097 636.80099 636.80832 636.80835 636.80852 636.80855
                      636.80887 636.80895 636.80896 636.80897 636.800929 524.3 524.4 524.7 524.6 612.46711 524.8
                      220.071 220.072 220.076 220.092 220.094 220.095 220.096 220.097 220.099 001.5436 612.46711
]
    delete_codes.each do |code|
      DeweyCode.find_by(code:)&.delete
    end

    [
      { code: '013', description: 'Of works by specific classes of authors', level: 3 },
      { code: '018', description: 'Author Catalogs', level: 3 },
      { code: '019', description: 'Dictionary Catalogs', level: 3 },
      { code: '024', description: 'Miscellany', level: 3 },
      { code: '029', description: 'Documentation', level: 3 },
      { code: '517', description: 'Calculus', level: 3 },
      { code: '259', description: 'Other ministries and church work', level: 3 },
      { code: '819', description: 'American literature in English outside the USA (optional)', level: 3 },
      { code: '574', description: 'Biology', level: 3 },
      { code: '291', description: 'Comparative Religion; Mythology (No Longer Used)', level: 3 },
      { code: '589', description: 'Fungi', level: 3 },
      { code: '625', description: 'Road and Railroad', level: 3 },
      { code: '439', description: 'Other Germanic languages', level: 3 },
      { code: '921', description: 'Philosophers and psychologists', level: 3 },
      { code: '922', description: 'Of Theology', level: 3 },
      { code: '923', description: 'People in social sciences', level: 3 },
      { code: '925', description: 'Of Science', level: 3 },
      { code: '926', description: 'Of Technology', level: 3 },
      { code: '927', description: 'Of Fine Arts', level: 3 },
      { code: '928', description: 'People in literature, history, biography, genealogy', level: 3 },
      { code: '459', description: 'Romanian, Rhaetian, Sardinian, Corsican', level: 3 },
      { code: '656', description: 'Transportation; Railroading, etc.', level: 3 },
      { code: '655', description: 'Printing; Publishing; Copyright', level: 3 },
      { code: '654', description: 'Romanian, Rhaetian, Sardinian, Corsican', level: 3 },
      { code: '469', description: 'Portuguese and Galician', level: 3 },
      { code: '778', description: 'Special Applications', level: 3 },
      { code: '479', description: 'Other Italic languages', level: 3 },
      { code: '489', description: 'Other Hellenic languages', level: 3 },
      { code: '789', description: 'Composers or Types of music', level: 3 },
      { code: '376', description: 'Education of Women', level: 3 },
      { code: '377', description: 'Religious, Ethical, and Secular', level: 3 }
    ].each do |attributes|
      DeweyCode.find_or_create_by!(attributes)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Failed to create DeweyCode: #{attributes}. Error: #{e.message}"
    rescue StandardError => e
      Rails.logger.error "Unexpected error for DeweyCode: #{attributes}. Error: #{e.message}"
    end
  end
end
