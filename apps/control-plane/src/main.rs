fn main() {
    if let Err(error) = evgl_catalog::validate() {
        eprintln!("invalid service catalog: {error}");
        std::process::exit(2);
    }
    println!("organization={}", evgl_catalog::ORGANIZATION);
    for service in evgl_catalog::SERVICES { println!("service={service}"); }
}
